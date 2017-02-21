# Supported tags and respective `Dockerfile` links

- [`8.5-jdk8`, `8.5`, `latest`, `8.5.6-jdk8` (*8.5-jdk8/Dockerfile*)](https://github.com/andreptb/Dockerfiles/blob/master/tomcat/8.5-jdk8/Dockerfile)
- [`8-jdk7`, `8.0.41-jdk7` (*8-jdk7/Dockerfile*)](https://github.com/andreptb/Dockerfiles/blob/master/tomcat/8-jdk7/Dockerfile)
- [`8-jdk8`, `8`, `8.0.41-jdk8` (*8-jdk8/Dockerfile*)](https://github.com/andreptb/Dockerfiles/blob/master/tomcat/8-jdk8/Dockerfile)
- [`7-jdk7`, `7.0.75-jdk7` (*7-jdk7/Dockerfile*)](https://github.com/andreptb/Dockerfiles/blob/master/tomcat/7-jdk7/Dockerfile)
- [`7-jdk8`, `7`, `7.0.75-jdk8` (*7-jdk8/Dockerfile*)](https://github.com/andreptb/Dockerfiles/blob/master/tomcat/7-jdk8/Dockerfile)
- [`6-jdk6`, `6.0.48-jdk6` (*6-jdk6/Dockerfile*)](https://github.com/andreptb/Dockerfiles/blob/master/tomcat/6-jdk6/Dockerfile)
- [`6-jdk7`, `6`, `6.0.48-jdk7` (*6-jdk7/Dockerfile*)](https://github.com/andreptb/Dockerfiles/blob/master/tomcat/6-jdk7/Dockerfile)

# What is Tomcat?

Apache Tomcat (or simply Tomcat) is an open source web server and servlet container developed by the Apache Software Foundation (ASF). Tomcat implements the Java Servlet and the JavaServer Pages (JSP) specifications from Oracle, and provides a "pure Java" HTTP web server environment for Java code to run in. In the simplest config Tomcat runs in a single operating system process. The process runs a Java virtual machine (JVM). Every single HTTP request from a browser to Tomcat is processed in the Tomcat process in a separate thread.

> [wikipedia.org/wiki/Apache_Tomcat](https://en.wikipedia.org/wiki/Apache_Tomcat)

![logo](https://raw.githubusercontent.com/docker-library/docs/master/tomcat/logo.png)Logo &copy; Apache Software Fountation

# How to use this image.

Run the default Tomcat server (`CMD ["catalina.sh", "run"]`):

```console
$ docker run -it --rm tomcat:8.0
```

You can test it by visiting `http://container-ip:8080` in a browser or, if you need access outside the host, on port 8888:

```console
$ docker run -it --rm -p 8888:8080 tomcat:8.0
```

You can then go to `http://localhost:8888` or `http://host-ip:8888` in a browser.

The default Tomcat environment in the image for versions 7 and 8 is:

	CATALINA_BASE:   /usr/local/tomcat
	CATALINA_HOME:   /usr/local/tomcat
	CATALINA_TMPDIR: /usr/local/tomcat/temp
	jdk_HOME:        /usr
	CLASSPATH:       /usr/local/tomcat/bin/bootstrap.jar:/usr/local/tomcat/bin/tomcat-juli.jar

The default Tomcat environment in the image for version 6 is:

	CATALINA_BASE:   /usr/local/tomcat
	CATALINA_HOME:   /usr/local/tomcat
	CATALINA_TMPDIR: /usr/local/tomcat/temp
	jdk_HOME:        /usr
	CLASSPATH:       /usr/local/tomcat/bin/bootstrap.jar

The configuration files are available in `/usr/local/tomcat/conf/`. By default, no user is included in the "manager-gui" role required to operate the "/manager/html" web application. If you wish to use this app, you must define such a user in `tomcat-users.xml`.

## What are the differences between this image and [docker-library/tomcat](https://github.com/docker-library/tomcat)?

* Uses andreptb/oracle-java](https://github.com/andreptb/Dockerfiles/blob/master/oracle-java) instead of [docker-library/java](https://github.com/docker-library/java).
* Provides base images with [Oracle JDK](http://www.oracle.com/technetwork/pt/java/javase/downloads/index.html) 6 (only tomcat 6), 7 and 8.
* [Alpine](http://alpinelinux.org) images with [APR](https://apr.apache.org/) support. Check below for more information.

# Alpine image

This image is based on the popular [Alpine Linux project](http://alpinelinux.org), available in [the `alpine` official image](https://hub.docker.com/_/alpine). Alpine Linux is much smaller than most distribution base images (~5MB), and thus leads to much slimmer images in general.

This variant is highly recommended when final image size being as small as possible is desired. See [this Hacker News comment thread](https://news.ycombinator.com/item?id=10782897) for more discussion of the issues that might arise and some pro/con comparisons of using Alpine-based images.

To minimize image size, it's uncommon for additional related tools (such as `git` or `bash`) to be included in Alpine-based images. Using this image as a base, add the things you need in your own Dockerfile (see the [`alpine` image description](https://hub.docker.com/_/alpine/) for examples of how to install packages if you are unfamiliar).

# License

View [license information](https://www.apache.org/licenses/LICENSE-2.0) for the software contained in this image.

# Supported Docker versions

This image is officially supported on Docker version 1.8.2.

Support for older versions (down to 1.0) is provided on a best-effort basis.

## Issues

If you have any problems with or questions about this image, please contact me through a [GitHub issue](https://github.com/andreptb/Dockerfiles/issues).
