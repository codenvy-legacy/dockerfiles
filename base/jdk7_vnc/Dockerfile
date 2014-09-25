FROM codenvy/jdk7

RUN sudo apt-get update && \
    sudo apt-get install -y --no-install-recommends supervisor x11vnc xvfb net-tools blackbox rxvt-unicode xfonts-terminus

# noVNC
RUN sudo mkdir /opt/noVNC && \
    wget -qO- "http://github.com/kanaka/noVNC/tarball/master" | sudo tar -zx --strip-components=1 -C /opt/noVNC
ADD index.html /opt/noVNC/

RUN sudo mkdir -p /etc/X11/blackbox && \
    echo "[begin] (Blackbox) \n [exec] (Terminal)     {urxvt -fn "xft:Terminus:size=12"} \n [end]" | sudo tee -a /etc/X11/blackbox/blackbox-menu

ADD supervisord.conf /opt/

RUN sudo sed -i '/exec "$@"/i/usr/bin/supervisord -c /opt/supervisord.conf\n' /entrypoint.sh

WORKDIR /home/user

EXPOSE 6080

CMD tail -f /home/user/supervisord.log

# === Usage ===
# ADD $app$ /home/user/application.jar
