# Supported tags and respective `Dockerfile` links

-	[`5.11.1`, `latest`  (*activemq/Dockerfile*)](https://github.com/andreptb/Dockerfiles/blob/master/activemq/Dockerfile)

[Docker](https://www.docker.io/) file for trusted builds of [ActiveMQ](http://activemq.apache.org/) on https://registry.hub.docker.com/u/andreptb/activemq/.

Run the latest container with:

    docker pull andreptb/activemq
    docker run -p 61616:61616 -p 8161:8161 andreptb/activemq

The Broker listens on port 61616 and the Web Console on port 8161.

# Customizing configuration and persistence location

ActiveMQ checks your environment for the variables *ACTIVEMQ_BASE*, *ACTIVEMQ_CONF* and *ACTIVEMQ_DATA*.
Just override them with your desired location:

    docker run -p 61616:61616 -p 8161:8161 -e ACTIVEMQ_CONF=/etc/activemq/conf -e ACTIVEMQ_DATA=var/lib/activemq/data andreptb/activemq

As an alternative you can just mount your persistent config and data directories into the default location:

    docker run -p 61616:61616 -p 8161:8161 -v /opt/activemq/conf:/opt/activemq/conf -v /var/activemq/data:/var/activemq/data andreptb/activemq

# Differences between this image and [rmohr/activemq](https://github.com/rmohr/docker-activemq)

* Uses [andreptb/oracle-java] instead of [java:7]
* Default activemq version is 5.11.1

# License

View [license information]http://www.apache.org/licenses/) for the software contained in this image.

# Supported Docker versions

This image is officially supported on Docker version 1.6.2.

# Issues

If you have any problems with or questions about this image, please contact me through a [GitHub issue](https://github.com/andreptb/Dockerfiles/issues).
