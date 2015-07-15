# Pull base image.
FROM debian:jessie

ENV JAVA_VERSION 7

# Install Java
RUN \
    echo oracle-java$JAVA_VERSION-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
    echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu precise main" | tee /etc/apt/sources.list.d/webupd8team-java.list && \
    apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys EEA14886 && \
    apt-get update && \
    apt-get -y install augeas-tools curl oracle-java$JAVA_VERSION-installer oracle-java$JAVA_VERSION-unlimited-jce-policy

# Define working directory.
WORKDIR /data

# Define commonly used JAVA_HOME variable
ENV JAVA_HOME /usr/lib/jvm/java-$JAVA_VERSION-oracle
