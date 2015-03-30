FROM codenvy/jdk7

RUN sudo apt-get update && \
    sudo apt-get install -y --no-install-recommends supervisor x11vnc xvfb net-tools blackbox rxvt-unicode xfonts-terminus g++ libqt4-dev

# download and install noVNC

RUN sudo mkdir -p /opt/noVNC/utils/websockify && \
    wget -qO- "http://github.com/kanaka/noVNC/tarball/master" | sudo tar -zx --strip-components=1 -C /opt/noVNC && \
    wget -qO- "https://github.com/kanaka/websockify/tarball/master" | sudo tar -zx --strip-components=1 -C /opt/noVNC/utils/websockify

ADD index.html /opt/noVNC/

RUN sudo mkdir -p /etc/X11/blackbox && \
    echo "[begin] (Blackbox) \n [exec] (Terminal)     {urxvt -fn "xft:Terminus:size=12"} \n [end]" | sudo tee -a /etc/X11/blackbox/blackbox-menu

ADD supervisord.conf /opt/

RUN sudo sed -i '/exec "$@"/i/usr/bin/supervisord -c /opt/supervisord.conf\n' /entrypoint.sh

WORKDIR /home/user

EXPOSE 6080

ENV CODENVY_APP_PORT_6080_HTTP 6080

CMD tail -f /home/user/supervisord.log

# === Usage ===
# ADD $app$ /home/user/application.jar
