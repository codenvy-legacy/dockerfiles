FROM debian:jessie

RUN apt-get update && \
    apt-get -y install sudo procps wget unzip gcc make
    
RUN echo "%sudo ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers && \
    useradd -u 5001 -G users,sudo -d /home/user -m user && \
    echo "secret\nsecret" | passwd user
    
RUN mkdir /opt/shellinabox && \
    wget -qO- "https://shellinabox.googlecode.com/files/shellinabox-2.14.tar.gz" | tar -zx --strip-components=1 -C /opt/shellinabox && \
    cd /opt/shellinabox && \
    ./configure && \
    make
    
USER user

EXPOSE 4200

ADD entrypoint.sh /entrypoint.sh    
RUN sudo chmod 755 /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
