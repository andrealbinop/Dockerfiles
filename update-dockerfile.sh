#!/bin/bash

# Error exit codes
E_BAD_USAGE=1
E_REPO_NOTFOUND=2
E_MISSING_PARAM=3


function usage() {
  echo \
"Usage: $0 [REPOSITORIES]

    Update the given [REPOSITORIES] Dockerfiles and README.
    If no repositories are given, it updates all available repositories.

Options:
    REPOSITORIES list of repositories to update.
"

  exit 0
}

# Log into STDOUT or STDERR accorddingly with $1 [msg_log_level] and LOG_LEVEL
#   LOG_LEVEL = 1 is default, so ERROR and INFO.
#
# Params:
#     $1 = [msg_log_level]: error | info | debug. Any other value is ignored
#          and treated as 'info'.
#   To disable all outputs, export LOG_LEVEL=-1
#   To enable all outputs, export LOG_LEVEL=2.
function log()
{
  case $1 in
    error) shift; log_error $@;;
    info) shift; log_info $@;;
    debug) shift; log_debug $@;;
    *) log_info $@;;
  esac
}

# Log into stderr info messages when LOG_LEVEL >= 0 (ERROR)
#   LOG_LEVEL = 1 is default, so this should always print
#   into console.
#   To disable this output, and all others, export LOG_LEVEL=-1
#   before call this script.
function log_error()
{
  if [[ $LOG_LEVEL -gt 0 ]]; then
    (>&2 echo $@)
  fi
}

# Log into stdout info messages when LOG_LEVEL >= 1 (INFO)
#   LOG_LEVEL = 1 is default, so this should always print
#   into console.
#   To disable this output, and all others, export LOG_LEVEL=0
#   before call this script.
function log_info()
{
  if [[ $LOG_LEVEL -gt 1 ]]; then
    echo $@
  fi
}

# Log into stdout debug messages when LOG_LEVEL >= 2 (DEBUG)
#   LOG_LEVEL = 1 is default, so this should not print into
#   console by default.
#   To enable this output, and all others, export LOG_LEVEL=2
function log_debug()
{
  if [[ $LOG_LEVEL -gt 2 ]]; then
    echo $@
  fi
}

# Cleanup all formatting from $(docker-template list) output line
#   Removes all coloring and hierarchy formatting from the output line.
#   Trims all whitespaces from BEGIN and END of the resulting line.
function cleanup_output()
{
  echo $1 \
  | sed -r "s/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[m|K]//g" `# remove color from $(docker-template list) output` \
  | sed -e 's/├─//g'  | sed -e 's/│//g'                  `# remove formating from $(docker-template list) output` \
  | sed -e 's/^ *//'  | sed -e 's/ *$//'                 `# trim output`
}

# Extract value / name from a $(docker-template list) output line
# that already have been cleaned up $(cleanup_output)
#
# Example:
#   [repo] tomcat => tomcat
#   [tag] 8-jdk7  => 8-jdk7
function get_line_value()
{
  echo $1 | cut -d " " -f 2
}

# Cache README.md inserting links to Dockerfile for each tag/alias
#
# Creates the README file into [repository_cache_readme_file].
#
# template file, that MUST be located inside
# 'repos/[REPOSITORY]' template dir, and insert "Supported tags"
# on its TOP
#
# Params:
#     - $1 = [repository]                  : repository name
#     - $2 = [repository_cache_readme_file]: path to cache README file
function create_readme()
{
  repository=$1
  repository_cache_readme_file=$2
  repository_template_dir="repos/${repository}"

  if [[ -z "$repository" ]]; then
    log error "Function [create_readme], required param [repository] not given."
    exit $E_MISSING_PARAM
  fi

  if [[ -z "$repo_cache_readme_file" ]]; then
    log error "Function [create_readme], required param [repo_cache_readme_file] not given."
    exit $E_MISSING_PARAM
  fi

  echo "# Supported tags and respective \`Dockerfile\` links" > "$repo_cache_readme_file"
  echo "" >> "$repo_cache_readme_file"
  tags=${REPO_TAGS[$repository]}
  for tag in $tags; do
    versions="\`$tag\`"

    aliases=${TAG_ALIASES[${repository}-${tag}]}
    for a in $aliases; do
      versions="$versions, \`$a\`"
    done

    echo "- [${versions} (*${tag}/Dockerfile*)](${PROJECT_URL}/blob/master/${repository}/${tag}/Dockerfile)" >> "$repo_cache_readme_file"
  done
  echo "" >> "$repo_cache_readme_file"
  cat "${repository_template_dir}/README.md" >> "$repo_cache_readme_file"
}

# Load all available Repositories data into global variables for
# further processing.
#
# Parses $(docker-template list) output into script global variables
#   - REPOSITORIES: list of available docker-template repos.
#                   String separated by [whitespaces].
#   - REPO_TAGS: associative array with a list of tags for each repository
#                [repository] in REPOSITORIES.
#                eg. REPO_TAGS[tomcat] => "8-jdk7 8-jdk8 7-jdk7 7-jdk8 6-jdk6 6-jdk7"
#   - TAG_ALIASES: associative array with a list of aliases for each
#                  [repository-tag].
#                eg. TAG_ALIASES[tomcat-8-jdk8] => "8 latest 8.0.36-jdk8"
function load_repositories() {
  REPOSITORIES=
  REPO_TAGS=
  TAG_ALIASES=

  IFS_BAK=$IFS
  IFS='
'
  for line in $(docker-template list); do
    clean_line=$(cleanup_output $line)
    log debug "line... ${line} => ${clean_line}"

    if [ -n "$(echo $clean_line | grep -E '\[repo\]')" ]; then
      REPO_NAME=$(get_line_value $clean_line)
      REPOSITORIES+=" ${REPO_NAME}"

      log debug "found repository => ${REPO_NAME} | repositories => ${REPOSITORIES}"
    fi

    if [ -n "$(echo $clean_line | grep -o -E '\[tag\]')" ]; then
      tag_name=$(get_line_value $clean_line)
      REPO_TAGS[$REPO_NAME]+=" ${tag_name}"

      log debug "found tag => ${tag_name} | repo_tags[${REPO_NAME}] => ${REPO_TAGS[$REPO_NAME]}"
    fi

    if [ -n "$(echo $clean_line | grep -o -E '\[alias\]')" ]; then
      alias_name=$(get_line_value $clean_line)
      TAG_ALIASES["${REPO_NAME}-${tag_name}"]+=" ${alias_name}"

      log debug "found alias => ${alias_name} | tag_aliases[${REPO_NAME}-${tag_name}] => ${TAG_ALIASES["${REPO_NAME}-${tag_name}"]}"
    fi
  done
  IFS=$IFS_BAK
}

# Update the given REPOSITORIES (params). If no repositories (params)
# are given update all available repositories.
#
# Params:
#     $@ = [REPOSITORIES]: array of repositories to update.
update_repositories() {
  requested_repositories=$@
  effective_repositories=

  load_repositories

  for r in $requested_repositories; do
    log info "Checking if repository [$r] exists"

    if [[ ! ${REPOSITORIES[@]} =~ $r ]]; then
      log info "Repository [${r}] not found."
      exit $E_REPO_NOTFOUND
    fi

    effective_repositories+=" ${r}"
  done

  # If there is no requested repository, uses all existing repositories
  effective_repositories=${effective_repositories:-$REPOSITORIES}

  for repository in $effective_repositories; do
    repo_template_dir="repos/${repository}"
    repo_target_dir="${repository}"
    repo_cache_dir="${repo_template_dir}/cache"
    repo_cache_readme_file="${repo_cache_dir}/README.md"

    tags=${REPO_TAGS[${repository}]}
    log info "================================================================="
    log info "repository = ${repository} => ${tags}"
    for tag in $tags; do
      aliases=${TAG_ALIASES[${repository}-${tag}]}
      log info "    tag = ${tag} => ${aliases}"
    done

    # Cache the updated Dockerfiles
    docker-template cache $repository

    # Generate and caches README
    readme=$(create_readme "$repository" "$repo_cache_readme_file")

    # Remove old files and copy new ones
    rm -rf "$repo_target_dir"
    mkdir "$repo_target_dir"
    cp "$repo_cache_readme_file" "$repo_target_dir"
    for tag in $tags; do
      repo_tag_target_dir="${repo_target_dir}/${tag}"
      mkdir -p "$repo_tag_target_dir"
      mv "${repo_cache_dir}/${tag}/Dockerfile" "$repo_tag_target_dir"
      ln -sr "${repo_target_dir}/README.md" "$repo_tag_target_dir"
    done

    # clean cache files
    rm -rf "$repo_cache_dir"
  done
}

LOG_LEVEL=${LOG_LEVEL:-1}
PROJECT_URL="https://github.com/andreptb/Dockerfiles"

REPO_NAME=$@
REPOSITORIES=
declare -A REPO_TAGS
declare -A TAG_ALIASES

cd "$(dirname $(readlink -f "$0"))"
log debug "Executing from ${PWD}"

case $1 in
  --help|help|-h) usage;;
  *) update_repositories $REPO_NAME;;
esac
