# Supported tags and respective `Dockerfile` links

-	[`latest`, `3.3.9-jdk8`, `3.3.9` (*jdk-8/Dockerfile*)](https://github.com/andreptb/Dockerfiles/blob/master/maven/jdk-8/Dockerfile)
-	[`3.3.9-jdk8-alpine` (*alpine/jdk-8/Dockerfile*)](https://github.com/andreptb/Dockerfiles/blob/master/maven/alpine/jdk-8/Dockerfile)
-	[`3.3.9-jdk7` (*jdk-7/Dockerfile*)](https://github.com/andreptb/Dockerfiles/blob/master/maven/jdk-7/Dockerfile)
-	[`3.3.9-jdk7-alpine` (*alpine/jdk-7/Dockerfile*)](https://github.com/andreptb/Dockerfiles/blob/master/maven/alpine/jdk-7/Dockerfile)
-	[`3.2.5`, `3.2.5-jdk6` (*jdk-6/Dockerfile*)](https://github.com/andreptb/Dockerfiles/blob/master/maven/jdk-6/Dockerfile)

# What is Maven?

[Apache Maven](http://maven.apache.org) is a software project management and comprehension tool. Based on the concept of a project object model (POM), Maven can manage a project's build, reporting and documentation from a central piece of information.

![logo](https://raw.githubusercontent.com/docker-library/docs/master/maven/logo.png)

# How to use this image

You can run a Maven project by using the Maven Docker image directly, passing a Maven command to `docker run`:

```console
$ docker run -it --rm --name my-maven-project -v "$PWD":/data andreptb/maven:3.3.3-jdk-7 mvn clean install
```

## What are the differences between this image and [library/maven](https://github.com/carlossg/docker-maven/blob/master/jdk-7/Dockerfile)?

* Uses [andreptb/oracle-java](../oracle/java/README.md) instead of [library/java](https://github.com/docker-library/java/blob/master/openjdk-7-jdk/Dockerfile).
* Provides base images with [Oracle JDK](http://www.oracle.com/technetwork/pt/java/javase/downloads/index.html) 7 and 8.
* [ONBUILD flavors](https://github.com/carlossg/docker-maven/blob/master/jdk-8/onbuild/Dockerfile) are not provided.

# License

View [license information](https://www.apache.org/licenses/) for the software contained in this image.

# Supported Docker versions

This image is officially supported on Docker version 1.8.1.

Support for older versions (down to 1.0) is provided on a best-effort basis.

**Important:** [JCE](http://www.oracle.com/technetwork/java/javase/downloads/jce8-download-2133166.html) is not available for java 6 version.

# Alpine image

This image is based on the popular [Alpine Linux project](http://alpinelinux.org), available in [the `alpine` official image](https://hub.docker.com/_/alpine). Alpine Linux is much smaller than most distribution base images (~5MB), and thus leads to much slimmer images in general.

This variant is highly recommended when final image size being as small as possible is desired. See [this Hacker News comment thread](https://news.ycombinator.com/item?id=10782897) for more discussion of the issues that might arise and some pro/con comparisons of using Alpine-based images.

To minimize image size, it's uncommon for additional related tools (such as `git` or `bash`) to be included in Alpine-based images. Using this image as a base, add the things you need in your own Dockerfile (see the [`alpine` image description](https://hub.docker.com/_/alpine/) for examples of how to install packages if you are unfamiliar).


# License

View [license information](http://www.oracle.com/technetwork/java/javase/terms/license/index.html) for the software contained in this image.

# Supported Docker versions

This image is officially supported on Docker version 1.6.2.

# Issues

If you have any problems with or questions about this image, please contact me through a [GitHub issue](https://github.com/andreptb/Dockerfiles/issues).
