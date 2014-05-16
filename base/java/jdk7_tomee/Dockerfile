FROM codenvy/jdk7

RUN mkdir /opt/tomee && \
    wget \
    -qO- \
    "http://apache.rediris.es/openejb/openejb-4.5.1/apache-tomee-1.5.1-webprofile.tar.gz" | tar -zxv --strip-components=1 -C /opt/tomee/ && \
    rm -rf /opt/tomee/webapps/*
     
EXPOSE 8080

WORKDIR /opt/tomee/bin

CMD ./catalina.sh run

# ===== Usage for Java web applications =====
# FROM codenvy/jdk7_tomee
# ADD $app$ /opt/tomee/webapps/ROOT.war
# ===== OR (debug) =====
# FROM codenvy/jdk7_tomee
# EXPOSE 8000
# CMD ./catalina.sh jpda run
# ADD $app$ /opt/tomee/webapps/ROOT.war
