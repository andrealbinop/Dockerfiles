# Supported tags and respective `Dockerfile` links

-	[`5.1.0.GA`, `latest`  (*jboss-as/5.1.0.GA/Dockerfile*)](https://github.com/andreptb/Dockerfiles/blob/master/jboss-as/5.1.0.GA/Dockerfile)
-	[`4.2.3.GA` (*jboss-as/4.2.3.GA/jdk-7/Dockerfile*)](https://github.com/andreptb/Dockerfiles/blob/master/jboss-as/4.2.3.GA/jdk-7/Dockerfile), [`4.2.3.GA-jdk7` (*jboss-as/4.2.3.GA/jdk-7/Dockerfile*)](https://github.com/andreptb/Dockerfiles/blob/master/jboss-as/4.2.3.GA/jdk-7/Dockerfile), [`4.2.3.GA-jdk6` (*jboss-as/4.2.3.GA/jdk-6/Dockerfile*)](https://github.com/andreptb/Dockerfiles/blob/master/jboss-as/4.2.3.GA/jdk-6/Dockerfile)
-	[`4.0.5.GA` (*jboss-as/4.0.5.GA/Dockerfile*)](https://github.com/andreptb/Dockerfiles/blob/master/jboss-as/4.0.5.GA/Dockerfile)

# JBossAS Docker image

This is a Dockerfile with [JBoss application server](http://wildfly.org/). Encompasses [legacy versions](http://jbossas.jboss.org/) of [JBoss application server](http://wildfly.org/), currently providing images for families [*4.X*](https://developer.jboss.org/wiki/JBossApplicationServerOfficialDocumentationPage) and [*5.X*](http://jbossas.jboss.org/docs/5-x). If you wish to use latest versions (which is now called **WildFly**), please use  [*andreptb/wildfly*](https://github.com/andreptb/Dockerfiles/blob/master/wildfly/jdk-8/Dockerfile) image.

**Important:** Only  [jboss-4.2.3.GA](https://github.com/andreptb/Dockerfiles/blob/master/jboss-as/4.2.3.GA/jdk-7/Dockerfile) image contains [Apache Ant](http://ant.apache.org/) build tool.

# JBossAS Documentation

Though some of the documentation do not apply because of **Docker**, you may find useful information [here](https://developer.jboss.org/wiki/JBossApplicationServerOfficialDocumentationPage).

## Usage

To boot with default command line args

    docker run -it -p 8080:8080 andreptb/jboss-as

To boot with a different configuration name (or any other valid command line arg)

    docker run -it -p 8080:8080 andreptb/jboss-as /opt/jboss/jboss4/bin/run.sh --configuration=<name>

When started web console can be accessed at:

    http://localhost:8080

## License

View [license information](http://www.gnu.org/licenses/lgpl-2.1-standalone.html) for the software contained in this image.

## Supported Docker versions

This image is officially supported on Docker version 1.6.2.

## Issues

If you have any problems with or questions about this image, please contact me through a [GitHub issue](https://github.com/andreptb/Dockerfiles/issues).
