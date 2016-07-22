#!/bin/bash


debug() {
  if [[ $DEBUG_MODE ]]; then
    echo $@
  fi
}

function get_line_value()
{
  echo $1 | sed -r "s/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[m|K]//g" | sed -e 's/├─//g' | sed -e 's/│//g' | sed -e 's/^ *//' | cut -d " " -f 2
}

## Cache README.md inserting tag links on top of README template
#
#
#
function generate_repository_readme()
{
  echo "# Supported tags and respective \`Dockerfile\` links
$repo_readme

" > $repo_readme_cache_file
  cat "${repo_template_dir}/README.md" >> ${repo_readme_cache_file}
}

# Copy Repository files from REPO cache to target dirs
function copy_repo_files()
{
  repo_target_dir=$repo_name

  # clean repository target dir
  rm -rf $repo_target_dir

  mkdir $repo_target_dir
  cp $repo_readme_cache_file $repo_target_dir

  IFS_BAK2=$IFS
  IFS=' '
  for t in $repo_tags; do
    repo_tag_target_dir="${repo_name}/${t}"
    mkdir -p "$repo_tag_target_dir"
    mv "${repo_cache_dir}/${t}/Dockerfile" $repo_tag_target_dir
    ln -sr "$repo_target_dir/README.md" $repo_tag_target_dir
  done
  IFS=$IFS_BAK2
}

function process_repository()
{
  if [ -n "$repo_name" ]; then
    repo_template_dir="repos/${repo_name}"
    repo_cache_dir="${repo_template_dir}/cache"
    repo_readme_cache_file="${repo_cache_dir}/README.md"

    echo "========================================================================"
    echo "repository: $repo_name"
    echo "tags: $repo_tags"
    echo "readme:
    $repo_readme"

    # generate Dokerfiles
    docker-template cache $repo_name

    generate_repository_readme

    copy_repo_files

    # clean cache files
    rm -rf $repo_cache_dir

    repo_name=""
    repo_readme=""
    repo_tags=""
  fi
}

function process_tag()
{
  # -	[`6.0.45-jdk6`, `6-jdk6` (*6/jdk-6/Dockerfile*)](https://github.com/andreptb/Dockerfiles/blob/master/tomcat/6/jdk-6/Dockerfile)
  if [ -n "$tag_name" ]; then
    versions="\`$tag_name\`"

    IFS_BAK2=$IFS
    IFS=' '
    for v in $tag_aliases; do
      versions="$versions, \`$v\`"
    done
    IFS=$IFS_BAK2

    tag_readme="- [${versions} (*${tag_name}/Dockerfile*)](https://github.com/andreptb/Dockerfiles/blob/master/${repo_name}/${tag_name}/Dockerfile)"
    repo_readme="${repo_readme}
${tag_readme}"

    tag_name=""
    tag_aliases=""
  fi
}

function update_repository() {
  IFS_BAK=$IFS
  IFS='
'
  for line in $(docker-template list); do
    debug "line....... $line"
    if [ -n "$(echo $line | grep -E '\[repo\]')" ]; then
      debug "found repository"

      process_repository
      repo_name=$(get_line_value $line)

      debug "repo_name=${repo_name}"
    fi

    if [ -n "$(echo $line | grep -o -E '\[tag\]')" ]; then
      debug "found tag"

      process_tag
      tag_name=$(get_line_value $line)
      repo_tags+=" ${tag_name}"

      debug "tag_name=${tag_name}"
      debug "repo_tags=${repo_tags[@]}"
    fi

    if [ -n "$(echo $line | grep -o -E '\[alias\]')" ]; then
      debug "found alias"

      alias_name=$(get_line_value $line)
      tag_aliases+=" ${alias_name}"

      debug "alias_name=${alias_name}"
      debug "tag_aliases=${tag_aliases[@]}"
    fi
  done
  IFS=$IFS_BAK

  process_tag
  process_repository
}

update_repository
