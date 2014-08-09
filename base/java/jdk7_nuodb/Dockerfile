FROM codenvy/jdk7

ADD http://download.nuohub.org/nuodb-2.0.4.linux.x64.deb /tmp/nuodb-2.0.4.linux.x64.deb

ENV JAVA_HOME /opt/jdk1.7.0_55

RUN sudo -E bash -c "dpkg --install /tmp/nuodb-2.0.4.linux.x64.deb" && \
    sudo rm /tmp/nuodb-2.0.4.linux.x64.deb

ADD startup.sh /home/user/startup.sh

RUN sudo chmod +x /home/user/startup.sh

CMD sudo /home/user/startup.sh