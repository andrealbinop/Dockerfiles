FROM andreptb/oracle-java:7-alpine
MAINTAINER Andre Albino Pereira <andreptb@gmail.com>

ENV CATALINA_HOME /usr/local/tomcat
ENV PATH $CATALINA_HOME/bin:$PATH
RUN mkdir -p "$CATALINA_HOME"
WORKDIR $CATALINA_HOME

ENV TOMCAT_MAJOR 7
ENV TOMCAT_VERSION 7.0.70
ENV MIRROR http://ftp.unicamp.br/pub

# see https://www.apache.org/dist/tomcat/tomcat-8/KEYS
RUN set -x \
  && apk --no-cache add --virtual build-dependencies wget ca-certificates tar alpine-sdk gnupg \
  && gpg --keyserver pool.sks-keyservers.net --recv-keys \
	05AB33110949707C93A279E3D3EFE6B686867BA6 \
	07E48665A34DCAFAE522E5E6266191C37C037D42 \
	47309207D818FFD8DCD3F83F1931D684307A10A5 \
	541FBE7D8F78B25E055DDEE13C370389288584E7 \
	61B832AC2F1C5A90F0F9B00A1C506407564C17A3 \
	79F7026C690BAA50B92CD8B66A3AD3F4F22C4FED \
	9BA44C2621385CB966EBA586F72C284D731FABEE \
	A27677289986DB50844682F8ACB77FC2E86E29AC \
	A9C5DF4D22E99998D9875A5110C01C5A2F6059E7 \
	DCFD35E0BF8CA7344752DE8B6FB21E8933C60243 \
	F3A04C595DB5B6A5F1ECA43E3B7BBB100D811BBE \
	F7DA48BB64BCB84ECBA7EE6935CD23C10D498E23 \
  && update-ca-certificates \
	&& wget -q  "${MIRROR}/apache/tomcat/tomcat-$TOMCAT_MAJOR/v$TOMCAT_VERSION/bin/apache-tomcat-$TOMCAT_VERSION.tar.gz" \
  && wget -q  "https://www.apache.org/dist/tomcat/tomcat-$TOMCAT_MAJOR/v$TOMCAT_VERSION/bin/apache-tomcat-$TOMCAT_VERSION.tar.gz.asc" \
  && gpg --verify apache-tomcat-$TOMCAT_VERSION.tar.gz.asc \
	&& tar -xf apache-tomcat-$TOMCAT_VERSION.tar.gz --strip-components=1 \
	&& rm bin/*.bat \
	&& rm apache-tomcat-$TOMCAT_VERSION.tar.gz \
  && cd /tmp \
  && wget -q "${MIRROR}/apache/tomcat/tomcat-connectors/native/1.2.7/source/tomcat-native-1.2.7-src.tar.gz" \
  && wget -q "${MIRROR}/apache/apr/apr-1.5.2.tar.gz" \
  && tar -xf apr-1.5.2.tar.gz && cd apr-1.5.2 && ./configure && make && make install \
  && cd /tmp && tar -xf tomcat-native-1.2.7-src.tar.gz && cd tomcat-native-1.2.7-src/native \
  && ./configure --with-apr=/usr/local/apr/bin --with-java-home=$JAVA_HOME --with-ssl=no --prefix=$CATALINA_HOME \
  && make && make install \
  && ln -sv $CATALINA_HOME/lib/libtcnative-1.so /usr/lib/ && ln -sv /lib/libz.so.1 /usr/lib/libz.so.1 \
  && rm -rf /tmp/* \
  && sed -i 's/SSLEngine="on"/SSLEngine="off"/g' $CATALINA_HOME/conf/server.xml \
  && apk del --purge build-dependencies

EXPOSE 8080
CMD ["catalina.sh", "run"]
