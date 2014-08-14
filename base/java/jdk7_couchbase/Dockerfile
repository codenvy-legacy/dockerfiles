FROM codenvy/jdk7

ENV CB_VERSION 2.2.0
ENV CB_BASE_URL http://packages.couchbase.com/releases
ENV CB_PACKAGE couchbase-server-community_${CB_VERSION}_x86_64.deb
ENV CB_DOWNLOAD_URL ${CB_BASE_URL}/${CB_VERSION}/${CB_PACKAGE}
ENV CB_LOCAL_PATH /tmp/${CB_PACKAGE}

ADD $CB_DOWNLOAD_URL $CB_LOCAL_PATH

RUN echo "deb ftp://ftp.debian.org/debian/ wheezy main" | sudo tee -a /etc/apt/sources.list && \
    echo "deb-src ftp://ftp.debian.org/debian/ wheezy main" | sudo tee -a /etc/apt/sources.list && \
    sudo apt-get update && \
    sudo apt-get -y --force-yes install librtmp0 python-httplib2 && \
    sudo dpkg -i $CB_LOCAL_PATH && \
    sudo rm $CB_LOCAL_PATH && \
    sudo service couchbase-server stop

ADD startup.sh /home/user/startup.sh

RUN sudo chmod +x /home/user/startup.sh

EXPOSE 8091 8092 11211

CMD sudo /home/user/startup.sh && while true;do true; done
