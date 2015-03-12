FROM debian:jessie

RUN apt-get update && \
    apt-get -y install sudo procps wget unzip mc gcc make && \
    echo "%sudo ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers && \
    useradd -u 5001 -G users,sudo -d /home/user --shell /bin/bash -m user && \
    echo "secret\nsecret" | passwd user && apt-get clean

USER user

EXPOSE 4200

ENV CODENVY_WEB_SHELL_PORT 4200

ADD entrypoint.sh /entrypoint.sh

# Shellinabox binaries are added. To build Shellinabox from source run:
#
# wget -qO- "https://shellinabox.googlecode.com/files/shellinabox-2.14.tar.gz" | tar -zx --strip-components=1 -C /opt/shellinabox
# cd /opt/shellinabox && \
#    ./configure && \
#    make
#
# When rebuilding from source, make sure you backup the following files
# that should be then added back to achive:
# /shellinabox/shellinabox/black-on-white.css
# /shellinabox/shellinabox/white-on-black.css
# Once done, zip the archive to be injected into the image

ADD shellinabox.zip /opt/shellinabox.zip

RUN sudo chown user:user -R /opt && \
    cd /opt && unzip shellinabox.zip && \
    rm -rf /opt/shellinabox.zip && \
    sudo chmod 755 /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]