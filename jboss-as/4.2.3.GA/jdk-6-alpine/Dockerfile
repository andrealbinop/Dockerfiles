FROM andreptb/oracle-java:6-alpine

# JBoss version
ENV JBOSS_VERSION 4.2.3.GA
ENV JBOSS_HOME /opt/jboss/jboss4

# default port
EXPOSE 8080

# Installs curl, required by wget ssl
#RUN apk update && apk add --no-cache curl
RUN apk update && apk add --no-cache openssl

# Installs jboss
#RUN cd $HOME && curl -L -o jboss-$JBOSS_VERSION.zip http://sourceforge.net/projects/jboss/files/JBoss/JBoss-$JBOSS_VERSION/jboss-$JBOSS_VERSION.zip/download && \
RUN cd $HOME && wget -q http://sourceforge.net/projects/jboss/files/JBoss/JBoss-$JBOSS_VERSION/jboss-$JBOSS_VERSION.zip/download -O jboss-$JBOSS_VERSION.zip && \
    unzip -qo jboss-$JBOSS_VERSION.zip && \
    mkdir -p /opt/jboss && \
    mv $HOME/jboss-$JBOSS_VERSION $JBOSS_HOME && \
    rm -rf jboss-$JBOSS_VERSION.zip $JBOSS_HOME/server/all $JBOSS_HOME/server/minimal $JBOSS_HOME/docs

CMD ["/opt/jboss/jboss4/bin/run.sh", "-b", "0.0.0.0"]
