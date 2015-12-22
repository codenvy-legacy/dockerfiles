FROM debian:jessie
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8
EXPOSE 8080 8000
RUN apt-get update && \
    apt-get -y install sudo procps wget unzip mc git curl subversion nmap  && \
    echo "%sudo ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers && \
    useradd -u 1000 -G users,sudo -d /home/user --shell /bin/bash -m user && \
    echo "secret\nsecret" | passwd user && apt-get clean

USER user

LABEL che:server:8080:ref=tomcat8 che:server:8080:protocol=http che:server:8000:ref=tomcat8-debug che:server:8000:protocol=http


ENV MAVEN_VERSION=3.2.2 \
    JAVA_VERSION=8u45 \
    JAVA_VERSION_PREFIX=1.8.0_45

ENV JAVA_HOME=/opt/jdk$JAVA_VERSION_PREFIX \
M2_HOME=/home/user/apache-maven-$MAVEN_VERSION

ENV PATH=$JAVA_HOME/bin:$M2_HOME/bin:$PATH

RUN mkdir /home/user/cbuild /home/user/tomcat8 /home/user/apache-maven-$MAVEN_VERSION && \
  wget \
  --no-cookies \
  --no-check-certificate \
  --header "Cookie: oraclelicense=accept-securebackup-cookie" \
  -qO- \
  "http://download.oracle.com/otn-pub/java/jdk/$JAVA_VERSION-b14/jdk-$JAVA_VERSION-linux-x64.tar.gz" | sudo tar -zx -C /opt/ && \
  wget -qO- "https://archive.apache.org/dist/maven/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz" | tar -zx --strip-components=1 -C /home/user/apache-maven-$MAVEN_VERSION/

ENV TERM xterm
ENV PATH_TO_CBUILD_PROJECTS_FOLDER /projects
ENV PATH_TO_CBUILD_LIBRARY_FOLDER /home/user/cbuild

RUN wget -qO- "http://archive.apache.org/dist/tomcat/tomcat-8/v8.0.24/bin/apache-tomcat-8.0.24.tar.gz" | tar -zx --strip-components=1 -C /home/user/tomcat8 && \
    rm -rf /home/user/tomcat8/webapps/*


ADD cbuild buildLibrary.sh clone_codenvy.sh projectsList.sh cbuild_autocompletion /home/user/cbuild/
RUN cd /home/user/cbuild && \
    sudo chmod a+x cbuild buildLibrary.sh clone_codenvy.sh projectsList.sh && \
    sudo chown -R user:user /home/user/cbuild

RUN /home/user/cbuild/cbuild --install

CMD tailf /dev/null
