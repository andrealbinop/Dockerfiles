FROM andreptb/oracle-java:7-alpine

# Wilfly version
ENV WILDFLY_VERSION 8.2.0.Final

# Set the JBOSS_HOME env variable
ENV JBOSS_HOME /opt/jboss/wildfly

# Installs WILDFLY
RUN apk add --no-cache --virtual=build-dependencies wget && \
    cd "/tmp" && \
    wget -q http://download.jboss.org/wildfly/$WILDFLY_VERSION/wildfly-$WILDFLY_VERSION.tar.gz && \
    tar xzvf wildfly-$WILDFLY_VERSION.tar.gz && \
    mkdir -p /opt/jboss && \
    mv /tmp/wildfly-$WILDFLY_VERSION $JBOSS_HOME && \
    apk del build-dependencies && \
    rm "/tmp/"*

# Expose the ports we're interested in
EXPOSE 8080

CMD ["/opt/jboss/wildfly/bin/standalone.sh", "-b", "0.0.0.0"]
