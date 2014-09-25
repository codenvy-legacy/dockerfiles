FROM codenvy/jdk7

RUN mkdir /home/user/jetty9 && \
    wget -qO- "http://ftp.acc.umu.se/mirror/eclipse.org/jetty/9.2.2.v20140723/dist/jetty-distribution-9.2.2.v20140723.tar.gz" | tar -zx --strip-components=1 -C /home/user/jetty9/
ADD jetty-logging.xml /home/user/jetty9/etc/jetty-logging.xml
EXPOSE 8080

WORKDIR /home/user/jetty9

CMD java -jar start.jar

# ===== Usage =====
# FROM codenvy/jdk7_jetty9
# ADD $app$ /home/user/jetty9/webapps/ROOT.war
# ===== OR (debug) =====
# FROM codenvy/jdk7_jetty9
# EXPOSE 8000
# CMD java -Xdebug -agentlib:jdwp=transport=dt_socket,address=8000,server=y,suspend=n -jar start.jar
# ADD $app$ /home/user/jetty9/webapps/ROOT.war
