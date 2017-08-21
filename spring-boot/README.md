# Supported tags and respective `Dockerfile` links

- [`jdk8-alpine`, `latest`](https://github.com/andreptb/Dockerfiles/blob/master/spring-boot/jdk-8/Dockerfile)

# What is Spring Boot?

Spring Boot makes it easy to create stand-alone, production-grade Spring based Applications that you can "just run". We take an opinionated view of the Spring platform and third-party libraries so you can get started with minimum fuss. Most Spring Boot applications need very little Spring configuration.

## Features

- Create stand-alone Spring applications
- Embed Tomcat, Jetty or Undertow directly (no need to deploy WAR files)
- Provide opinionated 'starter' POMs to simplify your Maven configuration
- Automatically configure Spring whenever possible
- Provide production-ready features such as metrics, health checks and externalized configuration
- Absolutely no code generation and no requirement for XML configuration
- The reference guide includes detailed descriptions of all the features, plus an extensive howto for common use cases.

> [projects.spring.io/spring-boot](http://projects.spring.io/spring-boot/)

![logo](http://projects.spring.io/spring-boot/img/project-icon-large.png)

Logo &copy; Spring Boot

# How to use this image.

> Note This image is not used alone, it serves as the basis for other images that use spring boot with jar.

To use it, you must use this image as the basis of another Dockerfile, such as:

```
FROM andreptb/spring-boot:jdk8-alpine
```

You can also customize some arguments such as:

```
ARG PATH_JAR="./target/"
ARG SPRING_PROFILES_ACTIVE="production"
ARG SERVER_PORT="8080"
ARG JAVA_OPTS="-Xmx1024m"
FROM andreptb/spring-boot:jdk8-alpine
```

Arguments and environment variables:

|Type|Name|Description|Default Value|
|--- |--- |--- |---  --- |
|ARG|PROFILES|Spring profile initializing argument application|default|
|ARG|PORT|Port that the Spring application will start and will be exposed in the container in argument|9999|
|ARG|SPRING_PROFILES_ACTIVE|Spring's profile initializing argument application|${PROFILES}|
|ARG|JAVA_OPTS|JAVA_OPTS initializing the argument application|-Xmx512m|
|ARG|SERVER_PORT|Port that the Spring application will start and will be exposed in the container in argument|${PORT}|
|ARG|PATH_JAR|Place where the jar to be copied to container is in argument|./target/|
|ENV|SPRING_PROFILES_ACTIVE|Spring profile initializing application|${SPRING_PROFILES_ACTIVE}|
|ENV|JAVA_OPTS|JAVA_OPTS initializing the application|${JAVA_OPTS}|
|ENV|SERVER_PORT|Port that the Spring application will start and will be exposed in the container|${SERVER_PORT}|
|ENV|PATH_JAR|Place where the jar to be copied to container is|${PATH_JAR}|


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
