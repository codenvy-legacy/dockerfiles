FROM centos
EXPOSE 8080 8000
RUN yum update -y && \
    yum -y install sudo procps wget unzip mc git curl subversion nmap && \
    echo "%wheel ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers && \
    useradd -u 1000 -G users,wheel -d /home/user --shell /bin/bash -m user -p secret && \
    sed -i 's/requiretty/!requiretty/g' /etc/sudoers

USER user

LABEL che:server:8080:ref=tomcat8 che:server:8080:protocol=http che:server:8000:ref=tomcat8-debug che:server:8000:protocol=http

ENV MAVEN_VERSION=3.2.2 \
    JAVA_VERSION=8u45 \
    JAVA_VERSION_PREFIX=1.8.0_45

ENV JAVA_HOME=/opt/jdk$JAVA_VERSION_PREFIX \
    M2_HOME=/opt/apache-maven-$MAVEN_VERSION

ENV PATH=$JAVA_HOME/bin:$M2_HOME/bin:$PATH

RUN mkdir /home/user/tomcat8 && sudo mkdir /opt/apache-maven-$MAVEN_VERSION && \
  wget \
  --no-cookies \
  --no-check-certificate \
  --header "Cookie: oraclelicense=accept-securebackup-cookie" \
  -qO- \
  "http://download.oracle.com/otn-pub/java/jdk/$JAVA_VERSION-b14/jdk-$JAVA_VERSION-linux-x64.tar.gz" | sudo tar -zx -C /opt/ && \
  sudo wget -qO- "https://archive.apache.org/dist/maven/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz" | sudo tar -zx --strip-components=1 -C /opt/apache-maven-$MAVEN_VERSION/

ENV TERM xterm

RUN wget -qO- "http://archive.apache.org/dist/tomcat/tomcat-8/v8.0.24/bin/apache-tomcat-8.0.24.tar.gz" | tar -zx --strip-components=1 -C /home/user/tomcat8 && \
    rm -rf /home/user/tomcat8/webapps/*

CMD tailf /dev/null
