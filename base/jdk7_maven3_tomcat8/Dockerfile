FROM codenvy/shellinabox

RUN wget \
    --no-cookies \
    --no-check-certificate \
    --header "Cookie: oraclelicense=accept-securebackup-cookie" \
    -qO- \
    "http://download.oracle.com/otn-pub/java/jdk/8u51-b16/jdk-8u51-linux-x64.tar.gz" | sudo tar -zx -C /opt/
     
ENV JAVA_HOME /opt/jdk1.8.0_51
RUN echo "export JAVA_HOME=$JAVA_HOME" >> /home/user/.bashrc
ENV PATH $JAVA_HOME/bin:$PATH
RUN echo "export PATH=$PATH" >> /home/user/.bashrc

RUN mkdir /home/user/tomcat8 && \
    wget -qO- "http://archive.apache.org/dist/tomcat/tomcat-8/v8.0.24/bin/apache-tomcat-8.0.24.tar.gz" | tar -zx --strip-components=1 -C /home/user/tomcat8 && \
    rm -rf /home/user/tomcat8/webapps/*
     
EXPOSE 8080
ENV CODENVY_APP_PORT_8080_HTTP 8080


RUN mkdir -p /home/user/maven3 && \
    wget -qO- "http://archive.apache.org/dist/maven/maven-3/3.1.1/binaries/apache-maven-3.1.1-bin.tar.gz" | tar -zx --strip-components=1 -C /home/user/maven3
ENV M2_HOME /home/user/maven3   
RUN echo "export M2_HOME=$M2_HOME" >> /home/user/.bashrc
ENV PATH $M2_HOME/bin:$PATH
RUN echo "export PATH=$PATH" >> /home/user/.bashrc
