# Supported tags and respective `Dockerfile` links

-	[`8`, `1.8.0_40`, `latest` (*oracle-java/jdk-8/Dockerfile*)](https://github.com/andreptb/Dockerfiles/blob/master/oracle-java/jdk-8/Dockerfile)
-	[`7`, `1.7.0_80`  (*oracle-java/jdk-7/Dockerfile*)](https://github.com/andreptb/Dockerfiles/blob/master/oracle-java/jdk-7/Dockerfile)
-	[`6`, `1.6.0_45`  (*oracle-java/jdk-6/Dockerfile*)](https://github.com/andreptb/Dockerfiles/blob/master/oracle-java/jdk-6/Dockerfile)

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

* Uses [dockerfile/debian:jessie](https://registry.hub.docker.com/_/debian/) instead of [Ubuntu](https://github.com/dockerfile/ubuntu).
* Uses [Oracle JDK](http://www.oracle.com/technetwork/pt/java/javase/downloads/index.html) instead of [OpenJDK](http://openjdk.java.net/).
* Installs [Java Cryptography Extension (JCE)](http://www.oracle.com/technetwork/java/javase/downloads/jce8-download-2133166.html).
* Pro

**Important:** [JCE](http://www.oracle.com/technetwork/java/javase/downloads/jce8-download-2133166.html) is not available for java 6 version.

# License

View [license information](http://www.oracle.com/technetwork/java/javase/terms/license/index.html) for the software contained in this image.

# Supported Docker versions

This image is officially supported on Docker version 1.6.2.

# Issues

If you have any problems with or questions about this image, please contact me through a [GitHub issue](https://github.com/andreptb/Dockerfiles/issues).
