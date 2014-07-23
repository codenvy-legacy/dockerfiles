FROM codenvy/jdk7

RUN sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10 && \
    echo 'deb http://downloads-distro.mongodb.org/repo/debian-sysvinit dist 10gen' | sudo tee /etc/apt/sources.list.d/mongodb.list && \
    sudo apt-get update && \
    sudo apt-get -y --no-install-recommends install adduser mongodb-org

ADD startup.sh /opt/startup.sh

RUN sudo chmod +x /opt/startup.sh

EXPOSE 27017

CMD sudo /opt/startup.sh