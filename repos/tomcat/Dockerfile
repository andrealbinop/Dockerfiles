FROM andreptb/oracle-java:<%= @meta.java_version %>
MAINTAINER <%= @meta.maintainer %>

ENV CATALINA_HOME="<%= @meta.catalina_home %>" \
    PATH="<%= @meta.catalina_home %>/bin:$PATH" \
    TOMCAT_MAJOR_VERSION=<%= @meta.tomcat_major_version %> \
    TOMCAT_MINOR_VERSION=<%= @meta.tomcat_minor_version %> \
    APACHE_MIRROR="https://archive.apache.org/dist" \
    APR_VERSION=<%= @meta.apr_version %> \
    TOMCAT_NATIVE_VERSION=<%= @meta.tomcat_native_version %>
RUN mkdir -p "${CATALINA_HOME}"
WORKDIR $CATALINA_HOME

RUN set -x \
  && apk --no-cache add --virtual build-dependencies wget ca-certificates tar alpine-sdk gnupg \
  && gpg --keyserver pool.sks-keyservers.net --recv-keys \<% @meta.tomcat_signing_key.split(" ").each do |sk| %>
        <%= sk %> \<% end %>
  && update-ca-certificates \
  && wget -q --no-check-certificate "${APACHE_MIRROR}/tomcat/tomcat-${TOMCAT_MAJOR_VERSION}/v${TOMCAT_MINOR_VERSION}/bin/apache-tomcat-${TOMCAT_MINOR_VERSION}.tar.gz" \
  && wget -q --no-check-certificate "${APACHE_MIRROR}/tomcat/tomcat-${TOMCAT_MAJOR_VERSION}/v${TOMCAT_MINOR_VERSION}/bin/apache-tomcat-${TOMCAT_MINOR_VERSION}.tar.gz.asc" \
  && gpg --verify "apache-tomcat-${TOMCAT_MINOR_VERSION}.tar.gz.asc" \
  && tar -xf "apache-tomcat-${TOMCAT_MINOR_VERSION}.tar.gz" --strip-components=1 \
  && rm bin/*.bat \
  && rm "apache-tomcat-${TOMCAT_MINOR_VERSION}.tar.gz" \
  && cd /tmp \
  && wget -q --no-check-certificate "${APACHE_MIRROR}/tomcat/tomcat-connectors/native/${TOMCAT_NATIVE_VERSION}/source/tomcat-native-${TOMCAT_NATIVE_VERSION}-src.tar.gz" \
  && wget -q --no-check-certificate "${APACHE_MIRROR}/apr/apr-${APR_VERSION}.tar.gz" \
  && tar -xf "apr-${APR_VERSION}.tar.gz" && cd "apr-${APR_VERSION}" && ./configure && make && make install \
  && cd /tmp && tar -xf "tomcat-native-${TOMCAT_NATIVE_VERSION}-src.tar.gz" && cd "tomcat-native-${TOMCAT_NATIVE_VERSION}-src/native" \
  && ./configure --with-apr="/usr/local/apr/bin" --with-java-home="$JAVA_HOME" --with-ssl=no --prefix="$CATALINA_HOME" \
  && make && make install \
  && ln -sv "${CATALINA_HOME}/lib/libtcnative-1.so" "/usr/lib/" && ln -sv "/lib/libz.so.1" "/usr/lib/libz.so.1" \
  && cd / \
  && rm -rf /tmp/* \
  && sed -i 's/SSLEngine="on"/SSLEngine="off"/g' "${CATALINA_HOME}/conf/server.xml" \
  && apk del --purge build-dependencies

EXPOSE 8080
CMD ["catalina.sh", "run"]
