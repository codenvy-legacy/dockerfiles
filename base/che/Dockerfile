FROM debian:jessie

ENV CHE_VERSION="3.11.9" \
    MAVEN_VERSION=3.2.2 \
    JAVA_VERSION=8u45 \
    JAVA_VERSION_PREFIX=1.8.0_45 \
    CHE_LOCAL_CONF_DIR=~/.codenvy

ENV JAVA_HOME=/opt/jdk$JAVA_VERSION_PREFIX \
    M2_HOME=/opt/apache-maven-$MAVEN_VERSION

ENV PATH=$JAVA_HOME/bin:$M2_HOME/bin:$PATH

RUN apt-get update && \
    apt-get install wget mc curl unzip sudo -y && \
    mkdir ~/che && \
    wget -q http://maven.codenvycorp.com/content/repositories/public/org/eclipse/che/sdk/assembly-sdk/$CHE_VERSION/assembly-sdk-$CHE_VERSION.zip -P /home/user && \
    unzip -q /home/user/assembly-sdk-$CHE_VERSION.zip -d ~/che && \
    rm ~/assembly-sdk-$CHE_VERSION.zip && \
    wget \
   --no-cookies \
   --no-check-certificate \
   --header "Cookie: oraclelicense=accept-securebackup-cookie" \
   -qO- \
   "http://download.oracle.com/otn-pub/java/jdk/$JAVA_VERSION-b14/jdk-$JAVA_VERSION-linux-x64.tar.gz" | tar -zx -C /opt/ && \
    echo "export JAVA_HOME=$JAVA_HOME" >> ~/.bashrc && \
    mkdir /opt/apache-maven-$MAVEN_VERSION/ && \
    sudo wget -qO- "https://archive.apache.org/dist/maven/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz" | tar -zx --strip-components=1 -C /opt/apache-maven-$MAVEN_VERSION/ && \
    echo "export M2_HOME=$M2_HOME" >> ~/.bashrc && \
    mkdir -p ~/.codenvy && \
    cd ~/.codenvy && \
    echo "export PATH=$PATH" >> ~/.bashrc && \
    sudo apt-get update && \
    sudo apt-get install -y -q git subversion && \
    sudo apt-get clean all && \
    mkdir -p ~/.codenvy && \
    cd ~/.codenvy && \
    touch preference.json profile.json vfs && \
    echo "1q2w3e=~/che/temp/fs-root" >> vfs && \
    echo "export CHE_LOCAL_CONF_DIR=$CHE_LOCAL_CONF_DIR" >> ~/.bashrc && \
    sudo chmod 757 -R ~/che && \
    sudo chmod 757 -R ~/.codenvy

ADD che.properties ~/.codenvy/che.properties

WORKDIR ~/che/bin

# expose 8080 port and a range of ports for runners
EXPOSE 8080 49152-49162

CMD ./che.sh run
