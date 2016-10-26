# Copyright (c) 2012-2016 Codenvy, S.A.
# All rights reserved. This program and the accompanying materials
# are made available under the terms of the Eclipse Public License v1.0
# which accompanies this distribution, and is available at
# http://www.eclipse.org/legal/epl-v10.html
# Contributors:
# Codenvy, S.A. - initial API and implementation

FROM ubuntu:14.04

ENV MAVEN_VERSION=3.3.9 \
    JAVA_VERSION=8u45 \
    JAVA_VERSION_PREFIX=1.8.0_45
ENV JAVA_HOME=/opt/jdk$JAVA_VERSION_PREFIX \
M2_HOME=/home/user/apache-maven-$MAVEN_VERSION
ENV TERM xterm
ENV LANG en_GB.UTF-8
ENV LANG en_US.UTF-8
RUN sudo locale-gen en_US.UTF-8
ENV PATH=$JAVA_HOME/bin:$M2_HOME/bin:$PATH
ENV ANDROID_HOME=/home/user/android-sdk-linux
ENV PATH=$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools:$PATH

LABEL che:server:6080:ref=VNC che:server:6080:protocol=http

RUN echo "%sudo ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers && \
    useradd -u 1000 -G users,sudo -d /home/user --shell /bin/bash -m user && \
    echo "secret\nsecret" | passwd user

USER user

RUN sudo dpkg --add-architecture i386 && \
    sudo apt-get update && sudo apt-get install -y --force-yes expect libswt-gtk-3-java lib32z1 lib32ncurses5 lib32stdc++6 supervisor x11vnc xvfb net-tools \
    blackbox rxvt-unicode xfonts-terminus sudo openssh-server procps \
    wget unzip mc curl software-properties-common python-software-properties && \
    sudo mkdir /var/run/sshd && \
    sudo sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd && \
    sudo add-apt-repository ppa:git-core/ppa && \
    sudo apt-get update && \
    sudo sudo apt-get install git subversion -y && \
    mkdir /home/user/apache-maven-$MAVEN_VERSION && \
    wget \
    --no-cookies \
    --no-check-certificate \
    --header "Cookie: oraclelicense=accept-securebackup-cookie" \
    -qO- \
    "http://download.oracle.com/otn-pub/java/jdk/$JAVA_VERSION-b14/jdk-$JAVA_VERSION-linux-x64.tar.gz" | sudo tar -zx -C /opt/ && \
    wget -qO- "https://archive.apache.org/dist/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz" | tar -zx --strip-components=1 -C /home/user/apache-maven-$MAVEN_VERSION/ && \
    cd /home/user && wget --output-document=android-sdk.tgz --quiet http://dl.google.com/android/android-sdk_r24.4.1-linux.tgz && tar -xvf android-sdk.tgz && rm android-sdk.tgz && \
    sudo apt-get clean && \
    sudo apt-get -y autoremove && \
    sudo rm -rf /var/lib/apt/lists/* && \
    echo y | android update sdk --all --force --no-ui --filter platform-tools,build-tools-21.1.1,android-21,sys-img-armeabi-v7a-android-21 && \
    echo "no" | android create avd \
                --name che \
                --target android-21 \
                --abi armeabi-v7a && \
    sudo mkdir -p /opt/noVNC/utils/websockify && \
    wget -qO- "http://github.com/kanaka/noVNC/tarball/master" | sudo tar -zx --strip-components=1 -C /opt/noVNC && \
    wget -qO- "https://github.com/kanaka/websockify/tarball/master" | sudo tar -zx --strip-components=1 -C /opt/noVNC/utils/websockify && \
    sudo mkdir -p /etc/X11/blackbox && \
    echo "[begin] (Blackbox) \n [exec] (Terminal)     {urxvt -fn "xft:Terminus:size=12"} \n \
          [exec] (Emulator) {emulator64-arm -avd che} \n \
          [end]" | sudo tee -a /etc/X11/blackbox/blackbox-menu && \
    echo "#! /bin/bash\n set -e\n sudo /usr/sbin/sshd -D &\n/usr/bin/supervisord -c /opt/supervisord.conf &\n exec \"\$@\"" > /home/user/entrypoint.sh && chmod a+x /home/user/entrypoint.sh

ADD index.html /opt/noVNC/
ADD supervisord.conf /opt/
RUN svn --version && \
    sed -i 's/# store-passwords = no/store-passwords = yes/g' /home/user/.subversion/servers && \
    sed -i 's/# store-plaintext-passwords = no/store-plaintext-passwords = yes/g' /home/user/.subversion/servers
ENTRYPOINT ["/home/user/entrypoint.sh"]
EXPOSE 4403 6080 22

WORKDIR /projects

CMD tail -f /dev/null
