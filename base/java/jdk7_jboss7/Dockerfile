FROM codenvy/jdk7

RUN mkdir /opt/jboss7 && \
    wget \
    -qO- \
    "http://download.jboss.org/jbossas/7.1/jboss-as-7.1.1.Final/jboss-as-7.1.1.Final.tar.gz" |tar -zxv --strip-components=1 -C /opt/jboss7/
RUN cd /opt/jboss7/standalone/configuration/ && \
    sed -i 's/enable-welcome-root="true"/enable-welcome-root="false"/g' standalone.xml && \
    sed -i 's/127.0.0.1/0.0.0.0/g' standalone.xml
EXPOSE 8080

WORKDIR /opt/jboss7/bin/

CMD ./standalone.sh

# ===== Usage =====
# FROM codenvy/jdk7_jboss7
# ADD $app$ /opt/jboss7/standalone/deployments/ROOT.war
# ===== OR (debug) =====
# FROM codenvy/jdk7_jboss7
# EXPOSE 8000
# ENV JAVA_OPTS "-Xdebug -Xnoagent -Xrunjdwp:transport=dt_socket,address=8000,server=y,suspend=n"
# ADD $app$ /opt/jboss7/standalone/deployments/ROOT.war
