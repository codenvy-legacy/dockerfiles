FROM codenvy/ubuntu_jdk8

# install xserver, blackbox, Chrome, Selenium webdriver

RUN cd /home/user && wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add - && \
    wget -q http://chromedriver.storage.googleapis.com/2.19/chromedriver_linux64.zip && \
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

CMD /usr/bin/supervisord -c /opt/supervisord.conf & \
    cd /home/user && sleep 3 && \
    ./chromedriver --port=4444 --whitelisted-ips='' & \
    sleep 365d
