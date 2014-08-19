FROM codenvy/jdk7

ENV DEBIAN_FRONTEND noninteractive

ADD http://s3.amazonaws.com/downloads.basho.com/riak/1.4/1.4.10/debian/7/riak_1.4.10-1_amd64.deb /tmp/riak_1.4.10-1_amd64.deb

RUN sudo apt-get update && \
    sudo -E bash -c "apt-get -y install adduser logrotate" && \
    sudo -E bash -c "dpkg -i /tmp/riak_1.4.10-1_amd64.deb" && \
    sudo rm /tmp/riak_1.4.10-1_amd64.deb && \
    sudo sed -i.bak 's/127.0.0.1/0.0.0.0/' /etc/riak/app.config

ADD startup.sh /home/user/startup.sh

RUN sudo chmod +x /home/user/startup.sh

#EXPOSE 8098 8087

CMD sudo /home/user/startup.sh