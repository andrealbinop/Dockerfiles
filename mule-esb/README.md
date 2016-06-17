# Supported tags and respective `Dockerfile` links


-	[`3.8.0`, `latest`  (*mule-esb/3.8.0/Dockerfile*)](https://github.com/andreptb/Dockerfiles/blob/master/mule-esb/3.8.0/Dockerfile)
-	[`3.7.0`, `latest`  (*mule-esb/3.7.0/Dockerfile*)](https://github.com/andreptb/Dockerfiles/blob/master/mule-esb/3.7.0/Dockerfile)
-	[`3.6.1`  (*mule-esb/3.6.1/Dockerfile*)](https://github.com/andreptb/Dockerfiles/blob/master/mule-esb/3.6.1/Dockerfile)
-	[`3.8.0-alpine`  (*mule-esb/alpine/3.8.0/Dockerfile*)](https://github.com/andreptb/Dockerfiles/blob/master/mule-esb/alpine/3.8.0/Dockerfile)
-	[`3.7.0-alpine`  (*mule-esb/alpine/3.7.0/Dockerfile*)](https://github.com/andreptb/Dockerfiles/blob/master/mule-esb/alpine/3.7.0/Dockerfile)
-	[`3.6.1-alpine`  (*mule-esb/alpine/3.6.1/Dockerfile*)](https://github.com/andreptb/Dockerfiles/blob/master/mule-esb/alpine/3.6.1/Dockerfile)

## How to use
```
docker pull andreptb/mule
```

### Usage

For a simple application using 8083 port as HTTP

```
docker run -d -name myMuleInstance -p 8083:8083 andreptb/mule
```

#### Noteworthy mount points

| Mount point       | Description                                                     |
|------------------ |-----------------------------------------------------------------|
|/opt/mule/apps     | Mule Application deployment directory                           |
|/opt/mule/domains  | Mule Domains deployment directory                               |
|/opt/mule/conf     | Configuration directory                                         |
|/opt/mule/logs     | Logs directory                                                  |


#### Exposed ports

| Port | Description                                                     |
|----- |-----------------------------------------------------------------|
| 8083 | Default HTTP port                                               |
| 8081 | Default HTTP port (Alpine)                                      |
| 1099 | JMX port (Alpine)                                               |


This means only exposed port is 8083, if the application has other needs you should use `-p` rather than `-P`

```
-p 1234:1234
```

Differences between this image and [vromero/mule-docker](https://github.com/vromero/mule-docker)
----

* Uses [andreptb/oracle-java] instead of [java:openjdk-8-jdk]
* Uses default port 8083 instead of 8081

### Alpine images

This image is based on the popular [Alpine Linux project](http://alpinelinux.org), available in [the `alpine` official image](https://hub.docker.com/_/alpine). Alpine Linux is much smaller than most distribution base images (~5MB), and thus leads to much slimmer images in general.

This variant is highly recommended when final image size being as small as possible is desired. See [this Hacker News comment thread](https://news.ycombinator.com/item?id=10782897) for more discussion of the issues that might arise and some pro/con comparisons of using Alpine-based images.

To minimize image size, it's uncommon for additional related tools (such as `git` or `bash`) to be included in Alpine-based images. Using this image as a base, add the things you need in your own Dockerfile (see the [`alpine` image description](https://hub.docker.com/_/alpine/) for examples of how to install packages if you are unfamiliar).
