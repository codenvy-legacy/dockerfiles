FROM codenvy/jdk7

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update

RUN apt-mark hold initscripts udev plymouth mountall
RUN dpkg-divert --local --rename --add /sbin/initctl && ln -sf /bin/true /sbin/initctl

# install our "base" environment
RUN apt-get install -y --no-install-recommends openssh-server pwgen sudo vim-tiny xterm git

RUN apt-get install -y blackbox
RUN apt-get install -y --no-install-recommends x11vnc xvfb
RUN apt-get install -y supervisor

# noVNC
RUN apt-get install -y net-tools
RUN git clone git://github.com/kanaka/noVNC /noVNC/
ADD index.html /noVNC/

# clean up after ourselves
RUN apt-get clean

ADD startup.sh /
ADD supervisord.conf /
EXPOSE 6080
EXPOSE 5900
EXPOSE 5901
EXPOSE 5902
EXPOSE 3000
EXPOSE 22
WORKDIR /
ENTRYPOINT ["/startup.sh"]
