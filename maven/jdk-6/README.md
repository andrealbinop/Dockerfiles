# Supported tags and respective `Dockerfile` links

-	[`latest`, `3.3.3-jdk8`, `3.3.3` (*jdk-7/Dockerfile*)](https://github.com/andreptb/Dockerfiles/blob/master/maven/jdk-8/Dockerfile)
-	[`3.3.3-jdk7` (*jdk-7/Dockerfile*)](https://github.com/andreptb/Dockerfiles/blob/master/maven/jdk-7/Dockerfile)

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

# License

View [license information](http://www.oracle.com/technetwork/java/javase/terms/license/index.html) for the software contained in this image.

# Supported Docker versions

This image is officially supported on Docker version 1.6.2.

# Issues

If you have any problems with or questions about this image, please contact me through a [GitHub issue](https://github.com/andreptb/Dockerfiles/issues).
