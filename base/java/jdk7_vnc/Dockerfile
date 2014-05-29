FROM codenvy/jdk7

RUN sudo apt-get install -y --no-install-recommends rxvt git blackbox x11vnc xvfb net-tools supervisor

# noVNC
RUN sudo git clone git://github.com/kanaka/noVNC /opt/noVNC/
ADD index.html /opt/noVNC/

RUN sudo mkdir /etc/X11/blackbox/ -p && \
    echo "[begin] (Blackbox) \n [exec] (rxvt)     {rxvt} \n [end]" | sudo tee -a /etc/X11/blackbox/blackbox-menu

#RUN sudo sed -i '/exec "$@"/isudo /usr/bin/supervisord -c /opt/supervisord.conf' /entrypoint.sh
ADD startup.sh /startup.sh
RUN sudo chmod 755 /startup.sh

ADD supervisord.conf /opt/

EXPOSE 6080
ENTRYPOINT ["/startup.sh"]
