FROM codenvy/jdk7

RUN mkdir /opt/jetty-9.1.5 && \
    wget \
    -qO- \
    "http://saimei.acc.umu.se/mirror/eclipse.org/jetty/stable-9/dist/jetty-distribution-9.1.5.v20140505.tar.gz" | tar -zxv --strip-components=1 -C /opt/jetty-9.1.5/
ADD jetty-logging.xml /opt/jetty-9.1.5/etc/jetty-logging.xml     
EXPOSE 8080

WORKDIR /opt/jetty-9.1.5

CMD java -jar start.jar

# ===== Usage =====
# FROM codenvy/jdk7_jetty9
# ADD $app$ /opt/jetty-9.1.5/webapps/ROOT.war
# ===== OR (debug) =====
# FROM codenvy/jdk7_jetty9
# EXPOSE 8000
# CMD java -Xdebug -agentlib:jdwp=transport=dt_socket,address=8000,server=y,suspend=n -jar start.jar
# ADD $app$ /opt/jetty-9.1.5/webapps/ROOT.war
