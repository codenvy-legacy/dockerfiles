FROM codenvy/jdk7

RUN wget \
    -qO- \
    "http://archive.apache.org/dist/tomcat/tomcat-7/v7.0.53/bin/apache-tomcat-7.0.53.tar.gz" | tar -zxv -C /opt/ && \
    rm -rf /opt/apache-tomcat-7.0.53/webapps/*
     
EXPOSE 8080

WORKDIR /opt/apache-tomcat-7.0.53/bin

CMD ./catalina.sh run