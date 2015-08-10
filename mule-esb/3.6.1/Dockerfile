FROM andreptb/oracle-java:7

ENV MULE_VERSION 3.6.1

RUN cd ~ && wget https://repository-master.mulesoft.org/nexus/content/repositories/releases/org/mule/distributions/mule-standalone/$MULE_VERSION/mule-standalone-$MULE_VERSION.tar.gz

RUN cd /opt && tar xvzf ~/mule-standalone-$MULE_VERSION.tar.gz && rm ~/mule-standalone-$MULE_VERSION.tar.gz && ln -s /opt/mule-standalone-$MULE_VERSION /opt/mule

# Define environment variables.
ENV MULE_HOME /opt/mule

# Define mount points.
VOLUME ["/opt/mule/logs", "/opt/mule/conf", "/opt/mule/apps", "/opt/mule/domains"]

# Define working directory.
WORKDIR /opt/mule

CMD [ "/opt/mule/bin/mule" ]

# Default http port
EXPOSE 8083
