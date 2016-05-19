FROM alpine:3.3

# Here we use several hacks collected from https://github.com/gliderlabs/docker-alpine/issues/11:
# 1. install GLibc (which is not the cleanest solution at all)
# 2. hotfix /etc/nsswitch.conf, which is apperently required by glibc and is not used in Alpine Linux

ENV JAVA_VERSION=8 \
    JAVA_UPDATE=72 \
    JAVA_BUILD=15 \
    JAVA_HOME="/usr/lib/jvm/default-jvm" \
    MAVEN_VERSION=3.3.9 \
    TOMCAT_HOME="/home/user/tomcat8"
ENV M2_HOME="/usr/lib/apache-maven-$MAVEN_VERSION"

ENV PATH $JAVA_HOME/bin:$M2_HOME/bin:$PATH

RUN apk add --no-cache --virtual=build-dependencies wget ca-certificates && \
    export ALPINE_GLIBC_BASE_URL="https://circle-artifacts.com/gh/andyshinn/alpine-pkg-glibc/6/artifacts/0/home/ubuntu/alpine-pkg-glibc/packages/x86_64" && \
    export ALPINE_GLIBC_PACKAGE="glibc-2.21-r2.apk" && \
    export ALPINE_GLIBC_BIN_PACKAGE="glibc-bin-2.21-r2.apk" && \
    wget "$ALPINE_GLIBC_BASE_URL/$ALPINE_GLIBC_PACKAGE" "$ALPINE_GLIBC_BASE_URL/$ALPINE_GLIBC_BIN_PACKAGE" && \
    apk add --no-cache --allow-untrusted "$ALPINE_GLIBC_PACKAGE" "$ALPINE_GLIBC_BIN_PACKAGE" && \
    /usr/glibc/usr/bin/ldconfig "/lib" "/usr/glibc/usr/lib" && \
    echo 'hosts: files mdns4_minimal [NOTFOUND=return] dns mdns4' >> /etc/nsswitch.conf && \
    rm "$ALPINE_GLIBC_PACKAGE" "$ALPINE_GLIBC_BIN_PACKAGE" && \
    apk add --update --no-cache openssh curl mc git sudo unzip bash ca-certificates && \
    cd "/tmp" && \
    wget -q --header "Cookie: oraclelicense=accept-securebackup-cookie;" \
        "http://download.oracle.com/otn-pub/java/jdk/${JAVA_VERSION}u${JAVA_UPDATE}-b${JAVA_BUILD}/jdk-${JAVA_VERSION}u${JAVA_UPDATE}-linux-x64.tar.gz" && \
    tar -xzf "jdk-${JAVA_VERSION}u${JAVA_UPDATE}-linux-x64.tar.gz" && \
    mkdir -p "/usr/lib/jvm" && \
    mv "/tmp/jdk1.${JAVA_VERSION}.0_${JAVA_UPDATE}" "/usr/lib/jvm/java-${JAVA_VERSION}-oracle" && \
    ln -s "java-${JAVA_VERSION}-oracle" "$JAVA_HOME" && \
    ln -s "$JAVA_HOME/bin/"* "/usr/bin/" && \
    rm -rf "$JAVA_HOME/"*src.zip && \
    wget -q "http://apache.ip-connect.vn.ua/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz" && tar -xzf "apache-maven-$MAVEN_VERSION-bin.tar.gz" && \
    mv "/tmp/apache-maven-$MAVEN_VERSION" "/usr/lib" && \
    rm "/tmp/"* && \
    adduser -S user -h /home/user -s /bin/bash -G root -u 1000 && \
    echo "%root ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers && \
    PASS=$(openssl rand -base64 32) && \
    echo -e "${PASS}\n${PASS}" | passwd user && \
    wget -q "https://archive.apache.org/dist/tomcat/tomcat-8/v8.0.29/bin/apache-tomcat-8.0.29.tar.gz" && tar -xzf "apache-tomcat-8.0.29.tar.gz" && \
    mv /tmp/apache-tomcat-8.0.29 /home/user/tomcat8/ && \
    rm -rf /home/user/tomcat8/webapps/* ** \
    rm /tmp/apache-tomcat-8.0.29.tar.gz && \
    chown -R user /home/user/

EXPOSE 22 8000 8080

USER user

WORKDIR /projects

CMD sudo /usr/bin/ssh-keygen -A && \
    sudo /usr/sbin/sshd -D && \
    tail -f /dev/null

