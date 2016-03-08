FROM codenvy/ubuntu_jdk8

RUN sudo apt-get update && \
    sudo apt-get install -y --no-install-recommends supervisor x11vnc xvfb net-tools blackbox rxvt-unicode xfonts-terminus libxi6 libgconf-2-4

# download and install noVNC

RUN sudo mkdir -p /opt/noVNC/utils/websockify && \
    wget -qO- "http://github.com/kanaka/noVNC/tarball/master" | sudo tar -zx --strip-components=1 -C /opt/noVNC && \
    wget -qO- "https://github.com/kanaka/websockify/tarball/master" | sudo tar -zx --strip-components=1 -C /opt/noVNC/utils/websockify

ADD index.html /opt/noVNC/

RUN sudo mkdir -p /etc/X11/blackbox && \
    echo "[begin] (Blackbox) \n [exec] (Terminal)     {urxvt -fn "xft:Terminus:size=12"} \n [end]" | sudo tee -a /etc/X11/blackbox/blackbox-menu

ADD supervisord.conf /opt/
RUN  echo "#! /bin/bash\n set -e\n sudo /usr/sbin/sshd -D &\n/usr/bin/supervisord -c /opt/supervisord.conf &\n exec \"\$@\"" > /home/user/entrypoint.sh && chmod a+x /home/user/entrypoint.sh
RUN cat /home/user/entrypoint.sh

WORKDIR /home/user

EXPOSE 6080
ENTRYPOINT ["/home/user/entrypoint.sh"]
CMD tail -f /dev/null