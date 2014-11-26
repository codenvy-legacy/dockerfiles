FROM codenvy/jdk7

RUN mkdir /home/user/jboss7 && \
    wget \
    -qO- \
    "http://download.jboss.org/jbossas/7.1/jboss-as-7.1.1.Final/jboss-as-7.1.1.Final.tar.gz" | tar -zx --strip-components=1 -C /home/user/jboss7/
RUN cd /home/user/jboss7/standalone/configuration/ && \
    sed -i 's/enable-welcome-root="true"/enable-welcome-root="false"/g' standalone.xml && \
    sed -i 's/127.0.0.1/0.0.0.0/g' standalone.xml && \
    sed -i 's/<deployment-scanner/<deployment-scanner auto-deploy-exploded="true"/g' standalone.xml

EXPOSE 8080
ENV CODENVY_APP_PORT_8080_HTTP 8080

WORKDIR /home/user/jboss7/bin/

CMD ./standalone.sh

# ===== Usage =====
# FROM codenvy/jdk7_jboss7
# ADD $app$ /home/user/jboss7/standalone/deployments/ROOT.war
# ===== OR (debug) =====
# FROM codenvy/jdk7_jboss7
# EXPOSE 8000
# ENV CODENVY_APP_PORT_8000_DEBUG 8000
# ENV JAVA_OPTS "-Xdebug -Xnoagent -Xrunjdwp:transport=dt_socket,address=8000,server=y,suspend=n"
# ADD $app$ /home/user/jboss7/standalone/deployments/ROOT.war
