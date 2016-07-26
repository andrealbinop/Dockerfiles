## Dockerfiles

This repository contains all base **Dockerfiles** for [Docker](https://www.docker.com/) that I used, published to [Docker registry](https://registry.hub.docker.com/).

# List of base images

* [oracle-java][oracle-java-readme]: Base image with [Oracle JDK][oracle-jdk], providing versions for java 6, 7 and 8. Additionally, updates [Java Cryptography Extension (JCE)][JCE].
* [maven][maven-readme]: Base image with [Apache Maven][apache-maven], providing versions for java 7 and 8.
* [tomcat][tomcat-readme]: Base image with [Apache Tomcat][apache-tomcat], providing versions with [Oracle JDK][oracle-jdk] 7 and 8.
* [wildfly][wildfly-readme]: Base image with [JBoss WildFly][wildfly], providing versions with [Oracle JDK][oracle-jdk] 7 and 8.
* [jboss-as][jboss-as-readme]: Base image with old versions of [JBoss Application Server][jboss-as], providing versions for families *4.X* and *5.X*.
* [mule-esb][mule-esb-readme]: Docker Image packaging for [MuleESB][mulesoft]  with [Oracle JDK][oracle-jdk] 7.
* [grunt][grunt-readme]: Debian Jessie based image with [NodeJS], [Grunt] and [Bower] installed.


# Development

This section cover information to anyone who may contribute to this project, or wants to tweak it for its own uses.

## Template-based images

For maintainability some base images are created using templates. Usually some images have multiple versions, e.g. based in major releases or OS-based images (Debian/Alpine). The `Dockerfiles` for different versions of an image, most of the time, are basically the same. Most common variables are product and dependency versions. Thus, it is really error prone manually modify many similar files. For those cases [docker-template] is used.

[Docker-template] is a utility tool written in [Ruby] that allows writing `Dockerfiles` using [ERB] templates. It also uses a `opts.yml` file to describe all variables for substitution. It is meant for deploying images right from templates, without saving it. Therefore, it usually does not keep generated `Dockerfiles`. We do keep these generated files, so we wrapped it up with a `update-dockerfile.sh` script. The script uses `docker-template cache` and `docker-template list` outputs to generate and update project files.

### Docker-template

As described earlier, the `update-dockerfile.sh` script depends on `docker-template`. The easiest way to have `docker-template` installed is to use the `Gemfile` provided. Simply run

```shell
bundler install
```

and `docker-template` should be available to you.

For reference how to use docker-template visit its [wiki][docker-template-wiki] and this 2 example projects: [jekyll][jekyll-docker] and [envygeeks-docker].

### Update-dockerfile

Following the `docker-template` schema, templates are located into `/repos/[image]` directory in this repository. The `/opts.yml` holds configurations applied to all images, like maintainer, or used in `FROM` directive (docker-template limitation). Each image, repository in docker-template lingo, has the following files under `/repos/[image]`:
* `Dockerfile`: ERB-templated dockerfile.
* `opts.yml`: Image specific configurations.
* `README.md`: Image README without the "Supported versions and tags" section. (extension of this project)

Example:
```shell
~/projects/andreptb-dockerfiles $ ls -lhR repos/tomcat
repos/tomcat:
total 36K
-rw-rw-r-- 1 user user 2,8K Jul 22 15:50 Dockerfile
-rw-rw-r-- 1 user user  619 Jul 22 15:50 opts.yml
-rw-rw-r-- 1 user user 3,9K Jul 22 15:50 README.md
```

Executing `update-dockerfile.sh`, it will create a `/[image]` directory within the repository root folder for each image inside `/repos/[image]`. This image folder will contain:
* a `README.md` generated from `/repos/[image]/README.md`, inserting a section of all tags (versions) provided (with links) on its top.
* a folder per `tag` in `opts.yml` with:
    * a symlink to the image's `README.md`
    * a plain `Dockerfile`

Example:
```shell
~/projects/andreptb-dockerfiles $ ls -lhR tomcat
tomcat:
total 40K
drwxrwxr-x 2 user user 4,0K Jul 22 15:50 6-jdk6
drwxrwxr-x 2 user user 4,0K Jul 22 15:50 6-jdk7
drwxrwxr-x 2 user user 4,0K Jul 22 15:50 7-jdk7
drwxrwxr-x 2 user user 4,0K Jul 22 15:50 7-jdk8
drwxrwxr-x 2 user user 4,0K Jul 22 15:50 8-jdk7
drwxrwxr-x 2 user user 4,0K Jul 22 15:50 8-jdk8
-rw-rw-r-- 1 user user 4,7K Jul 22 15:50 README.md

tomcat/6-jdk6:
total 16K
-rw-rw-r-- 1 user user 2,7K Jul 22 15:50 Dockerfile
lrwxrwxrwx 1 user user   12 Jul 22 15:50 README.md -> ../README.md

tomcat/6-jdk7:
total 16K
-rw-rw-r-- 1 user user 2,7K Jul 22 15:50 Dockerfile
lrwxrwxrwx 1 user user   12 Jul 22 15:50 README.md -> ../README.md

tomcat/7-jdk7:
total 16K
-rw-rw-r-- 1 user user 2,7K Jul 22 15:50 Dockerfile
lrwxrwxrwx 1 user user   12 Jul 22 15:50 README.md -> ../README.md

tomcat/7-jdk8:
total 16K
-rw-rw-r-- 1 user user 2,7K Jul 22 15:50 Dockerfile
lrwxrwxrwx 1 user user   12 Jul 22 15:50 README.md -> ../README.md

tomcat/8-jdk7:
total 16K
-rw-rw-r-- 1 user user 2,7K Jul 22 15:50 Dockerfile
lrwxrwxrwx 1 user user   12 Jul 22 15:50 README.md -> ../README.md

tomcat/8-jdk8:
total 16K
-rw-rw-r-- 1 user user 2,7K Jul 22 15:50 Dockerfile
lrwxrwxrwx 1 user user   12 Jul 22 15:50 README.md -> ../README.md
```


The script supports update all images or a list of given ones.

```shell
# update all images/repositories in docker-template lingo
./update-dockerfile.sh

# update only tomcat image
./update-dockerfile.sh tomcat

# update tomcat and oracle-java images
./update-dockerfile.sh tomcat oracle-java
```

Uses `./update-dockerfile.sh --help` for usage.

[oracle-java-readme]: oracle-java/README.md
[maven-readme]: maven/README.md
[tomcat-readme]: tomcat/README.md
[wildfly-readme]: wildfly/README.md
[jboss-as-readme]: jboss-as/README.md
[mule-esb-readme]: mule-esb/README.md
[grunt-readme]: grunt/README.md

[oracle-jdk]: http://www.oracle.com/technetwork/pt/java/javase/downloads/index.html
[JCE]: http://www.oracle.com/technetwork/java/javase/downloads/jce8-download-2133166.html
[apache-maven]: https://maven.apache.org/
[apache-tomcat]: http://tomcat.apache.org/
[wildfly]: http://wildfly.org/
[jboss-as]: http://jbossas.jboss.org/
[mulesoft]: http://www.mulesoft.org/
[nodejs]: https://nodejs.org/
[grunt]: http://gruntjs.com/
[bower]: http://bower.io/

[docker-template]: https://github.com/envygeeks/docker-template
[docker-template-wiki]: https://github.com/envygeeks/docker-template/wiki
[envygeeks-docker]: https://github.com/envygeeks/docker/
[jekyll-docker]: https://github.com/jekyll/docker/
[ruby]: https://ruby-lang.org/
[erb]: https://en.wikipedia.org/wiki/ERuby
