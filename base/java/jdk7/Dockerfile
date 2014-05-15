FROM debian:jessie

RUN apt-get update && \
    apt-get -y install wget
    
RUN wget \
    --no-cookies \
    --no-check-certificate \
    --header "Cookie: oraclelicense=accept-securebackup-cookie" \
    -qO- \
    "http://download.oracle.com/otn-pub/java/jdk/7u55-b13/jdk-7u55-linux-x64.tar.gz" | tar -zxv -C /opt/
     
ENV JAVA_HOME /opt/jdk1.7.0_55
ENV PATH $JAVA_HOME/bin:$PATH