FROM andreptb/oracle-java:6

# JBoss version
ENV JBOSS_VERSION 5.1.0.GA
ENV JBOSS_HOME /opt/jboss/jboss5

# default port
EXPOSE 8080

# Installs jboss
RUN cd $HOME && \
    apt-get update && apt-get install -y unzip && \
    wget -q http://sourceforge.net/projects/jboss/files/JBoss/JBoss-$JBOSS_VERSION/jboss-$JBOSS_VERSION.zip/download -O jboss-$JBOSS_VERSION.zip && \
    unzip -qo jboss-$JBOSS_VERSION.zip && \
    mkdir -p /opt/jboss && \
    mv $HOME/jboss-$JBOSS_VERSION $JBOSS_HOME && \
    rm -rf jboss-$JBOSS_VERSION.zip $JBOSS_HOME/server/all $JBOSS_HOME/server/minimal $JBOSS_HOME/docs

CMD ["/opt/jboss/jboss5/bin/run.sh", "-b", "0.0.0.0"]
