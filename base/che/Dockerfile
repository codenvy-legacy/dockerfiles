FROM codenvy/shellinabox

ENV CHE_VERSION="3.11.9" \
    MAVEN_VERSION=3.2.2 \
    JAVA_VERSION=8u45 \
    JAVA_VERSION_PREFIX=1.8.0_45 \
    CHE_LOCAL_CONF_DIR=/home/user/.codenvy

ENV JAVA_HOME=/opt/jdk$JAVA_VERSION_PREFIX \
    M2_HOME=/opt/apache-maven-$MAVEN_VERSION
 
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
    "http://download.oracle.com/otn-pub/java/jdk/$JAVA_VERSION-b14/jdk-$JAVA_VERSION-linux-x64.tar.gz" | sudo tar -zx -C /opt/ && \
    echo "export JAVA_HOME=$JAVA_HOME" >> /home/user/.bashrc && \
    mkdir /opt/apache-maven-$MAVEN_VERSION/ && \
    sudo wget -qO- "https://archive.apache.org/dist/maven/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz" | sudo tar -zx --strip-components=1 -C /opt/apache-maven-$MAVEN_VERSION/ && \
    echo "export M2_HOME=$M2_HOME" >> /home/user/.bashrc && \
    mkdir -p /home/user/.codenvy && \
    echo "export PATH=$PATH" >> /home/user/.bashrc && \
    sudo apt-get update && sudo apt-get install -y -q git subversion && \
    sudo apt-get clean all && \
    cd /home/user/.codenvy && \
    touch preference.json profile.json vfs && \
    echo "1q2w3e=/home/user/che/temp/fs-root" >> vfs && \
    echo "export CHE_LOCAL_CONF_DIR=$CHE_LOCAL_CONF_DIR" >> /home/user/.bashrc && \
    sudo chmod 757 -R /home/user/che && \
    sudo chmod 757 -R /home/user/.codenvy

ADD che.properties /home/user/.codenvy/che.properties
WORKDIR /home/user/che/bin

# expose 8080 port and a range of ports for runners
EXPOSE 8080 49152-49162
CMD ./che.sh run
