FROM andreptb/oracle-java:8

# Define environment variables.
ENV MULE_HOME /opt/mule
ENV MULE_VERSION 3.8.0

RUN cd ~ && wget https://repository-master.mulesoft.org/nexus/content/repositories/releases/org/mule/distributions/mule-standalone/${MULE_VERSION}/mule-standalone-${MULE_VERSION}.tar.gz

RUN cd /opt && tar xvzf ~/mule-standalone-*.tar.gz && rm ~/mule-standalone-*.tar.gz && mv /opt/mule-standalone-* /opt/mule

# Define mount points.
VOLUME ["${MULE_HOME}/logs", "${MULE_HOME}/conf", "${MULE_HOME}/apps", "/${MULE_HOME}/domains"]

# Define working directory.
WORKDIR /opt/mule

CMD [ "/opt/mule/bin/mule" ]

# Default http port
EXPOSE 8083
