## Java Dockerfile


**Dockerfile** for [Oracle Java](http://www.oracle.com/technetwork/pt/java/javase/downloads/index.html)

This image is intended to be used mainly as a parent image for other images, such as Java application servers or executable jars.

### Base Image

* [dockerfile/debian](http://dockerfile.github.io/#/debian)

### Docker Tags

`andreptb/oracle-java` provides multiple tags:

* `latest` (default): Oracle JDK 8 (alias for `8`)
* `8`: Oracle Java 8 JDK
* `7`: Oracle Java 7 JDK
* `6`: Oracle Java 8 JDK
* `1.8.0_40`: Oracle Java 8 JDK update 40
* `1.7.0_80`: Oracle Java 7 JDK update 80
* `1.6.0_45`: Oracle Java 6 JDK update 45

For example, you can run a `Oracle Java 8` with the command:

    docker run -it --rm andreptb/oracle-java java -version

### Differences for [library/java](https://github.com/dockerfile/java) base image

* Uses [dockerfile/debian:wheezy](http://dockerfile.github.io/#/debian) instead of [Ubuntu](https://github.com/dockerfile/ubuntu).
* Uses o [Oracle JDK](http://www.oracle.com/technetwork/pt/java/javase/downloads/index.html) instead of [OpenJDK](http://openjdk.java.net/).
* Installs [Java Cryptography Extension (JCE)](http://www.oracle.com/technetwork/java/javase/downloads/jce8-download-2133166.html).

**Important:** [JCE]((http://www.oracle.com/technetwork/java/javase/downloads/jce8-download-2133166.html) is not available for java 6 version.

### Uso

    docker run -it --rm docker-web.softplan.com.br/base/oracle-java

#### Rode `java`

    docker run -it --rm docker-web.softplan.com.br/base/oracle-java java

#### Rode `javac`

    docker run -it --rm docker-web.softplan.com.br/base/oracle-java javac
