FROM codenvy/jdk7

ENV JAVA_HOME /opt/jdk1.7.0_55

RUN wget -q -O /tmp/nuodb-2.0.4.linux.x64.deb "http://download.nuohub.org/nuodb-2.0.4.linux.x64.deb" && \
    sudo -E bash -c "dpkg --install /tmp/nuodb-2.0.4.linux.x64.deb" && \
    sudo rm /tmp/nuodb-2.0.4.linux.x64.deb

ADD startup.sh /home/user/startup.sh

RUN sudo chmod +x /home/user/startup.sh

CMD sudo /home/user/startup.sh