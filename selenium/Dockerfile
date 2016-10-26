# Copyright (c) 2012-2016 Codenvy, S.A.
# All rights reserved. This program and the accompanying materials
# are made available under the terms of the Eclipse Public License v1.0
# which accompanies this distribution, and is available at
# http://www.eclipse.org/legal/epl-v10.html
# Contributors:
# Codenvy, S.A. - initial API and implementation

FROM ubuntu

EXPOSE 8080 8000
RUN apt-get update && \
    apt-get -y install sudo procps wget unzip mc curl && \
    echo "%sudo ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers && \
    useradd -u 1000 -G users,sudo -d /home/user --shell /bin/bash -m user && \
    echo "secret\nsecret" | passwd user

# install xserver, blackbox, Chrome, Selenium webdriver

USER user

RUN cd /home/user && wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add - && \
    wget -q http://chromedriver.storage.googleapis.com/2.24/chromedriver_linux64.zip && \
    unzip -q chromedriver_linux64.zip && rm chromedriver_linux64.zip

USER root

RUN echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list

USER user

RUN sudo apt-get update -qqy && \
  sudo apt-get -qqy install \
  google-chrome-stable \
  supervisor \
  x11vnc \
  xvfb \
  subversion \
  net-tools \
  blackbox \
  rxvt-unicode \
  xfonts-terminus && \
  sudo rm /etc/apt/sources.list.d/google-chrome.list \
  sudo rm -rf /var/lib/apt/lists/*

# download and install noVNC, configure Blackbox

RUN sudo mkdir -p /opt/noVNC/utils/websockify && \
    wget -qO- "http://github.com/kanaka/noVNC/tarball/master" | sudo tar -zx --strip-components=1 -C /opt/noVNC && \
    wget -qO- "https://github.com/kanaka/websockify/tarball/master" | sudo tar -zx --strip-components=1 -C /opt/noVNC/utils/websockify && \
    sudo mkdir -p /etc/X11/blackbox && \
    echo "[begin] (Blackbox) \n [exec] (Terminal)     {urxvt -fn "xft:Terminus:size=14"} \n \
    [exec] (Chrome)     {/opt/google/chrome/google-chrome} \n \
    [end]" | sudo tee -a /etc/X11/blackbox/blackbox-menu

ADD index.html  /opt/noVNC/
ADD supervisord.conf /opt/
EXPOSE 4444 6080 32745
ENV DISPLAY :20.0

ENV MAVEN_VERSION=3.3.9 \
    JAVA_VERSION=8u45 \
    JAVA_VERSION_PREFIX=1.8.0_45 \
    TOMCAT_HOME=/home/user/tomcat8

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
  wget -qO- "http://apache.ip-connect.vn.ua/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz" | tar -zx --strip-components=1 -C /home/user/apache-maven-$MAVEN_VERSION/
ENV TERM xterm

RUN wget -qO- "http://archive.apache.org/dist/tomcat/tomcat-8/v8.0.24/bin/apache-tomcat-8.0.24.tar.gz" | tar -zx --strip-components=1 -C /home/user/tomcat8 && \
    rm -rf /home/user/tomcat8/webapps/*


ENV LANG en_GB.UTF-8
ENV LANG en_US.UTF-8
RUN echo "export JAVA_HOME=/opt/jdk$JAVA_VERSION_PREFIX\nexport M2_HOME=/home/user/apache-maven-$MAVEN_VERSION\nexport TOMCAT_HOME=/home/user/tomcat8\nexport PATH=$JAVA_HOME/bin:$M2_HOME/bin:$PATH" >> /home/user/.bashrc && \
    sudo locale-gen en_US.UTF-8

WORKDIR /projects

CMD /usr/bin/supervisord -c /opt/supervisord.conf & \
    cd /home/user && sleep 3 && \
    ./chromedriver --port=4444 --whitelisted-ips='' & \
    sleep 365d
