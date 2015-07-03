FROM codenvy/shellinabox
MAINTAINER Codenvy

# Download the latest Che

ENV CHE_VERSION="3.10.3" CODENVY_LOCAL_CONF_DIR=/home/user/.codenvy JAVA_HOME=/opt/jdk1.8.0_45  M2_HOME=/opt/apache-maven-3.3.3
ENV PATH=$JAVA_HOME/bin:$M2_HOME/bin:$PATH

RUN mkdir /home/user/che && \
    wget -q http://maven.codenvycorp.com/content/repositories/public/org/eclipse/che/sdk/assembly-sdk/$CHE_VERSION/assembly-sdk-$CHE_VERSION.zip -P /home/user && \
    unzip -q /home/user/assembly-sdk-$CHE_VERSION.zip -d /home/user/che && \
    rm /home/user/assembly-sdk-$CHE_VERSION.zip && \
     wget \
   --no-cookies \
   --no-check-certificate \
   --header "Cookie: oraclelicense=accept-securebackup-cookie" \
   -qO- \
   "http://download.oracle.com/otn-pub/java/jdk/8u45-b14/jdk-8u45-linux-x64.tar.gz" | sudo tar -zx -C /opt/ && \
    echo "export JAVA_HOME=$JAVA_HOME" >> /home/user/.bashrc && \
    mkdir /opt/apache-maven-3.3.3/ && \
    sudo wget -qO- "http://apache.ip-connect.vn.ua/maven/maven-3/3.3.3/binaries/apache-maven-3.3.3-bin.tar.gz" | sudo tar -zx --strip-components=1 -C /opt/apache-maven-3.3.3/ && \
    echo "export M2_HOME=$M2_HOME" >> /home/user/.bashrc && \
    mkdir -p /home/user/.codenvy && \
    cd /home/user/.codenvy && \
    touch PreferencesStore.json ProfileStorage.json vfs && \
    echo "1q2w3e=/home/user/che/temp/fs-root" >> vfs && \
    echo "export PATH=$PATH" >> /home/user/.bashrc && \
    sudo apt-get update && \
    sudo apt-get install -y -q git && \
    sudo apt-get clean all && \
    mkdir -p /home/user/.codenvy && \
    cd /home/user/.codenvy && \
    touch PreferencesStore.json ProfileStorage.json vfs && \
    echo "1q2w3e=/home/user/che/temp/fs-root" >> vfs && \
    echo "export CODENVY_LOCAL_CONF_DIR=$CODENVY_LOCAL_CONF_DIR" >> /home/user/.bashrc && \
    sudo chmod 757 -R /home/user/che && \
    sudo chmod 757 -R /home/user/.codenvy

ADD codenvy-api-configuration.properties /home/user/.codenvy/codenvy-api-configuration.properties

WORKDIR /home/user/che/bin

# expose 8080 port and a range of ports for runners
EXPOSE 8080 49152-49162

CMD ./che.sh run
