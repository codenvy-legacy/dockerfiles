# Copyright (c) 2012-2016 Codenvy, S.A.
# All rights reserved. This program and the accompanying materials
# are made available under the terms of the Eclipse Public License v1.0
# which accompanies this distribution, and is available at
# http://www.eclipse.org/legal/epl-v10.html
# Contributors:
# Codenvy, S.A. - initial API and implementation

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
EXPOSE 6080
WORKDIR /projects
CMD /usr/bin/supervisord -c /opt/supervisord.conf && tail -f /dev/null
