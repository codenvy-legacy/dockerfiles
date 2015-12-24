FROM ubuntu

ENV JAVA_VERSION=8u65 \
    JAVA_VERSION_PREFIX=1.8.0_65
ENV JAVA_HOME /opt/jre$JAVA_VERSION_PREFIX

RUN apt-get update && \
    apt-get -y install \
    sudo \
    procps \
    wget \
    unzip \
    mc \
    curl \
    software-properties-common \
    python-software-properties && \
    echo "%sudo ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers && \
    useradd -u 1000 -G users,sudo -d /home/user --shell /bin/bash -m user && \
    echo "secret\nsecret" | passwd user && \
    add-apt-repository ppa:git-core/ppa && \
    apt-get update && \
    sudo apt-get install git -y && \
    apt-get clean && \
    wget \
   --no-cookies \
   --no-check-certificate \
   --header "Cookie: oraclelicense=accept-securebackup-cookie" \
   -qO- \
   "http://download.oracle.com/otn-pub/java/jdk/$JAVA_VERSION-b17/jre-$JAVA_VERSION-linux-x64.tar.gz" | tar -zx -C /opt/ && \
    apt-get -y autoremove \
    && apt-get -y clean \
    && rm -rf /var/lib/apt/lists/*
USER user
CMD ["tail", "-f", "/dev/null"]
