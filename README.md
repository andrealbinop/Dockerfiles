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

For maintainability some base images are created using templates. For instance:

- Tomcat

These images are based in [docker-template] project. It provides the infrastructure, parsing e generation of the `Dockerfiles` based in [ERB] templates. It also uses variables defined in `opts.yml` files to drive the templated data. For details about how to write images based in docker-template, see [docker-template wiki][docker-template-wiki], as its example projects [jekyll-docker] and [envygeeks-docker].

**Docker-template** is not meant to handle the images as we do here. More than just processing the templates, it focus in **building** and **pushing** directly the images. We use it only as an engine to parse our templates, but we keep the resulting `Dockerfiles`. As we use webhooks to trigger images build and push to [Docker Hub][docker-hub]. To fill the gap, we use the [docker-template-wrapper], a shell script wrapper around **docker-template** that allow us to manage the images just as we do here.

See **docker-template-wrapper** [README][docker-template-wrapper-readme] to know how to use it.

[oracle-java-readme]: oracle-java/README.md
[maven-readme]: maven/README.md
[tomcat-readme]: tomcat/README.md
[wildfly-readme]: wildfly/README.md
[jboss-as-readme]: jboss-as/README.md
[mule-esb-readme]: mule-esb/README.md
[grunt-readme]: grunt/README.md

[docker-hub]: https://hub.docker.com/

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
[docker-template-wrapper]: https://github.com/rflbianco/docker-template-wrapper
[docker-template-wrapper-readme]: https://github.com/rflbianco/docker-template-wrapper/blob/master/README.md
