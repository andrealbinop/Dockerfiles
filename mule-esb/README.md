# Supported tags and respective `Dockerfile` links

-	[`3.6.1`, `latest`  (*mule-esb/3.6.1/Dockerfile*)](https://github.com/andreptb/Dockerfiles/blob/master/mule-esb/3.6.1/Dockerfile)

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


This means only exposed port is 8083, if the application has other needs you should use `-p` rather than `-P`

```
-p 1234:1234
```

Differences between this image and [vromero/mule-docker](https://github.com/vromero/mule-docker)
----

* Uses [andreptb/oracle-java] instead of [java:openjdk-8-jdk]
* Uses default port 8083 instead of 8081
* Uses mule standalone 3.6.1 instead of 3.7.0
