FROM debian:jessie

RUN apt-get update && \
    apt-get -y install sudo procps wget unzip mc && \
    echo "%sudo ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers && \
    useradd -u 5001 -G users,sudo -d /home/user --shell /bin/bash -m user && \
    echo "secret\nsecret" | passwd user && apt-get clean && \
    usermod -u 1000 user && \
    sudo apt-get install -y -q git subversion apt-transport-https \
    ca-certificates \
    curl \
    lxc \
    iptables && \
    apt-get clean all

USER user

RUN curl -sSL https://get.docker.com/ | sh && \
    sudo usermod -aG docker user

ENV CHE_VERSION="3.12.5.1" \
    MAVEN_VERSION=3.2.2 \
    JAVA_VERSION=8u45 \
    JAVA_VERSION_PREFIX=1.8.0_45 \
    CHE_LOCAL_CONF_DIR=/home/user/.che

ENV JAVA_HOME=/opt/jdk$JAVA_VERSION_PREFIX \
    M2_HOME=/opt/apache-maven-$MAVEN_VERSION

ENV PATH=$JAVA_HOME/bin:$M2_HOME/bin:$PATH

RUN mkdir /home/user/che-$CHE_VERSION && \
    wget -q http://maven.codenvycorp.com/content/repositories/public/org/eclipse/che/sdk/assembly-sdk/$CHE_VERSION/assembly-sdk-$CHE_VERSION.zip -P /home/user && \
    unzip -q /home/user/assembly-sdk-$CHE_VERSION.zip -d /home/user && \
    cp -a /home/user/assembly-sdk-$CHE_VERSION/. /home/user/che-$CHE_VERSION/ && \
    rm /home/user/assembly-sdk-$CHE_VERSION.zip && \
    rm -rf /home/user/assembly-sdk-$CHE_VERSION && \
    wget \
    --no-cookies \
    --no-check-certificate \
    --header "Cookie: oraclelicense=accept-securebackup-cookie" \
    -qO- \
    "http://download.oracle.com/otn-pub/java/jdk/$JAVA_VERSION-b14/jdk-$JAVA_VERSION-linux-x64.tar.gz" | sudo tar -zx -C /opt/ && \
    echo "export JAVA_HOME=$JAVA_HOME" >> /home/user/.bashrc && \
    sudo mkdir /opt/apache-maven-$MAVEN_VERSION/ && \
    sudo wget -qO- "https://archive.apache.org/dist/maven/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz" | sudo tar -zx --strip-components=1 -C /opt/apache-maven-$MAVEN_VERSION/ && \
    echo "export M2_HOME=$M2_HOME" >> /home/user/.bashrc && \
    mkdir -p /home/user/.che && \
    echo "export PATH=$PATH" >> /home/user/.bashrc && \
    cd /home/user/.che && \
    touch preference.json profile.json vfs && \
    echo "1q2w3e=/home/user/che-$CHE_VERSION/temp/fs-root" >> vfs && \
    echo "export CHE_LOCAL_CONF_DIR=$CHE_LOCAL_CONF_DIR" >> /home/user/.bashrc && \
    sudo chmod 757 -R /home/user/che-$CHE_VERSION && \
    sudo chmod 757 -R /home/user/.che

ADD che.properties /home/user/.che/che.properties
ADD ./wrapdocker /usr/local/bin/wrapdocker
RUN sudo chmod +x /usr/local/bin/wrapdocker
WORKDIR /home/user/che-$CHE_VERSION/bin

# expose 8080 port and a range of ports for runners
EXPOSE 8080 49152-49162
CMD sudo wrapdocker & ./che.sh run