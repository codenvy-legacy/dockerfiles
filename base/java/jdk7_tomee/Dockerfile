FROM codenvy/jdk7

RUN mkdir /home/user/tomee && \
    wget -qO- "http://apache.volia.net/tomee/tomee-1.7.0/apache-tomee-1.7.0-webprofile.tar.gz" | tar -zx --strip-components=1 -C /home/user/tomee/ && \
    rm -rf /home/user/tomee/webapps/*
     
EXPOSE 8080

WORKDIR /home/user/tomee/bin

CMD ./catalina.sh run

# ===== Usage for Java web applications =====
# FROM codenvy/jdk7_tomee
# ADD $app$ /home/user/tomee/webapps/ROOT.war
# ===== OR (debug) =====
# FROM codenvy/jdk7_tomee
# EXPOSE 8000
# CMD ./catalina.sh jpda run
# ADD $app$ /home/user/tomee/webapps/ROOT.war
