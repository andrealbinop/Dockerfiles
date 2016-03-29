# Supported tags and respective `Dockerfile` links

-	[`8.2.0.Final`, `8.2.0.Final.jdk8`, `latest` (*wildfly/jdk-8/Dockerfile*)](https://github.com/andreptb/Dockerfiles/blob/master/wildfly/jdk-8/Dockerfile)
-	[`8.2.0.Final-alpine`, `8.2.0.Final.jdk8-alpine` (*wildfly/alpine/jdk-8/Dockerfile*)](https://github.com/andreptb/Dockerfiles/blob/master/wildfly/alpine/jdk-8/Dockerfile)
-	[`8.2.0.Final.jdk7` (*wildfly/jdk-7/Dockerfile*)](https://github.com/andreptb/Dockerfiles/blob/master/wildfly/jdk-7/Dockerfile)
-	[`8.2.0.Final.jdk7-alpine` (*wildfly/alpine/jdk-7/Dockerfile*)](https://github.com/andreptb/Dockerfiles/blob/master/wildfly/alpine/jdk-7/Dockerfile)

# WildFly Docker image

This is a Dockerfile with [WildFly application server](http://wildfly.org/). It's strongly inspired by [official WildFly Docker image](https://github.com/jboss-dockerfiles/wildfly).

## Usage

To boot in standalone mode

    docker run -it andreptb/wildfly

To boot in domain mode

    docker run -it andreptb/wildfly /opt/jboss/wildfly/bin/domain.sh -b 0.0.0.0 -bmanagement 0.0.0.0

## What are the differences between this image and [jboss/wildfly](https://github.com/dockerfile/java)?

* Uses [andreptb/oracle-java](../oracle/java/README.md) instead of [jboss/base-jdk:7](https://github.com/JBoss-Dockerfiles/base-jdk/tree/jdk7).
* Provides base images with [Oracle JDK](http://www.oracle.com/technetwork/pt/java/javase/downloads/index.html) 7 and 8.

## Application deployment

With the WildFly server you can [deploy your application in multiple ways](https://docs.jboss.org/author/display/WFLY8/Application+deployment):

1. You can use CLI
2. You can use the web console
3. You can use the management API directly
4. You can use the deployment scanner

The most popular way of deploying an application is using the deployment scanner. In WildFly this method is enabled by default and the only thing you need to do is to place your application inside of the `deployments/` directory. It can be `/opt/jboss/wildfly/standalone/deployments/` or `/opt/jboss/wildfly/domain/deployments/` depending on [which mode](https://docs.jboss.org/author/display/WFLY8/Operating+modes) you choose (standalone is default in the `andreptb/wildfly` image -- see above).

The simplest and cleanest way to deploy an application to WildFly running in a container started from the `andreptb/wildfly` image is to use the deployment scanner method mentioned above.

To do this you just need to extend the `andreptb/wildfly` image by creating a new one. Place your application inside the `deployments/` directory with the `ADD` command (but make sure to include the trailing slash on the deployment folder path, [more info](https://docs.docker.com/reference/builder/#add)). You can also do the changes to the configuration (if any) as additional steps (`RUN` command).  

[A simple example](https://github.com/goldmann/wildfly-docker-deployment-example) was prepared to show how to do it, but the steps are following:

1. Create `Dockerfile` with following content:

        FROM andreptb/wildfly
        ADD your-awesome-app.war /opt/jboss/wildfly/standalone/deployments/
2. Place your `your-awesome-app.war` file in the same directory as your `Dockerfile`.
3. Run the build with `docker build --tag=wildfly-app .`
4. Run the container with `docker run -it wildfly-app`. Application will be deployed on the container boot.

This way of deployment is great because of a few things:

1. It utilizes Docker as the build tool providing stable builds
2. Rebuilding image this way is very fast (once again: Docker)
3. You only need to do changes to the base WildFly image that are required to run your application

## Logging

Logging can be done in many ways. [This blog post](https://goldmann.pl/blog/2014/07/18/logging-with-the-wildfly-docker-image/) describes a lot of them.

## Customizing configuration

Sometimes you need to customize the application server configuration. There are many ways to do it and [this blog post](https://goldmann.pl/blog/2014/07/23/customizing-the-configuration-of-the-wildfly-docker-image/) tries to summarize it.

## Extending the image

To be able to create a management user to access the administration console create a Dockerfile with the following content

    FROM andreptb/wildfly
    RUN /opt/jboss/wildfly/bin/add-user.sh admin Admin#70365 --silent
    CMD ["/opt/jboss/wildfly/bin/standalone.sh", "-b", "0.0.0.0", "-bmanagement", "0.0.0.0"]

Then you can build the image:

    docker build --tag=andreptb/wildfly-admin .

Run it:

    docker run -it -p 9990:9990 andreptb/wildfly-admin

The administration console should be available at http://localhost:9990.

## Alpine image

This image is based on the popular [Alpine Linux project](http://alpinelinux.org), available in [the `alpine` official image](https://hub.docker.com/_/alpine). Alpine Linux is much smaller than most distribution base images (~5MB), and thus leads to much slimmer images in general.

This variant is highly recommended when final image size being as small as possible is desired. See [this Hacker News comment thread](https://news.ycombinator.com/item?id=10782897) for more discussion of the issues that might arise and some pro/con comparisons of using Alpine-based images.

To minimize image size, it's uncommon for additional related tools (such as `git` or `bash`) to be included in Alpine-based images. Using this image as a base, add the things you need in your own Dockerfile (see the [`alpine` image description](https://hub.docker.com/_/alpine/) for examples of how to install packages if you are unfamiliar).

## License

View [license information](http://www.gnu.org/licenses/lgpl-2.1-standalone.html) for the software contained in this image.

## Supported Docker versions

This image is officially supported on Docker version 1.6.2.

## Issues

If you have any problems with or questions about this image, please contact me through a [GitHub issue](https://github.com/andreptb/Dockerfiles/issues).
