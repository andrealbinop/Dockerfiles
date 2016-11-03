# Supported tags and respective `Dockerfile` links

-	[`8`, `1.8.0_112`, `8-alpine`, `1.8.0_112-alpine`, `latest` (*oracle-java/jdk-8/Dockerfile*)](https://github.com/andreptb/Dockerfiles/blob/master/oracle-java/jdk-8/Dockerfile) [![](https://badge.imagelayers.io/andreptb/oracle-java:1.8.0_91.svg)](https://imagelayers.io/?images=andreptb/oracle-java:1.8.0_91 'Get your own badge on imagelayers.io')
-	[`7`, `1.7.0_80`, `7-alpine`, `1.7.0_80-alpine` (*oracle-java/jdk-7/Dockerfile*)](https://github.com/andreptb/Dockerfiles/blob/master/oracle-java/jdk-7/Dockerfile) [![](https://badge.imagelayers.io/andreptb/oracle-java:1.7.0_80.svg)](https://imagelayers.io/?images=andreptb/oracle-java:1.7.0_80 'Get your own badge on imagelayers.io')
-	[`6`, `1.6.0_45`, `6-alpine`, `1.6.0_45-alpine`  (*oracle-java/jdk-6/Dockerfile*)](https://github.com/andreptb/Dockerfiles/blob/master/oracle-java/jdk-6/Dockerfile) [![](https://badge.imagelayers.io/andreptb/oracle-java:1.6.0_45.svg)](https://imagelayers.io/?images=andreptb/oracle-java:1.6.0_45 'Get your own badge on imagelayers.io')

# What is Java?

Java is a concurrent, class-based, object-oriented language specifically designed to have as few implementation dependencies as possible. It is intended to allow application developers to "write once, run anywhere", meaning that code that runs on one platform does not need to be recompiled to run on another.

Java is a registered trademark of Oracle and/or its affiliates.

> [wikipedia.org/wiki/Java_(programming_language)](http://en.wikipedia.org/wiki/Java_%28programming_language%29)

![logo](https://raw.githubusercontent.com/docker-library/docs/master/java/logo.png)

# How to use this image

## Start a Java instance in your app

The most straightforward way to use this image is to use a Java container as both the build and runtime environment. In your `Dockerfile`, writing something along the lines of the following will compile and run your project:

	FROM andreptb/oracle-java:7
	COPY . /data
	WORKDIR /data
	RUN javac Main.java
	CMD ["java", "Main"]

You can then run and build the Docker image:

	docker build -t my-java-app .
	docker run -it --rm --name my-running-app my-java-app

## Compile your app inside the Docker container

There may be occasions where it is not appropriate to run your app inside a container. To compile, but not run your app inside the Docker instance, you can write something like:

	docker run --rm -v "$PWD":/data -w /data java:7 javac Main.java

This will add your current directory as a volume to the container, set the working directory to the volume, and run the command `javac Main.java` which will tell Java to compile the code in `Main.java` and output the Java class file to `Main.class`.

# What are the differences between this image and [library/java](https://github.com/dockerfile/java)?

* Uses only [dockerfile/alpine:3.4](https://hub.docker.com/_/alpine/).
* Uses [Oracle JDK](http://www.oracle.com/technetwork/pt/java/javase/downloads/index.html) instead of [OpenJDK](http://openjdk.java.net/).
* Installs [Java Cryptography Extension (JCE)](http://www.oracle.com/technetwork/java/javase/downloads/jce8-download-2133166.html).

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
