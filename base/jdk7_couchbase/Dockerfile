FROM codenvy/jdk7

# download and latest community version as of March 13, 2015

ENV CB_VERSION 3.0.1
ENV CB_BASE_URL http://packages.couchbase.com/releases
ENV CB_PACKAGE couchbase-server-community_${CB_VERSION}-debian7_amd64.deb
ENV CB_DOWNLOAD_URL ${CB_BASE_URL}/${CB_VERSION}/${CB_PACKAGE}
ENV CB_LOCAL_PATH /tmp/${CB_PACKAGE}

RUN echo "deb ftp://ftp.debian.org/debian/ wheezy main" | sudo tee -a /etc/apt/sources.list && \
    echo "deb-src ftp://ftp.debian.org/debian/ wheezy main" | sudo tee -a /etc/apt/sources.list && \
    sudo apt-get update && \
    sudo apt-get -y --force-yes install librtmp0 python-httplib2 && \
    wget -q -O $CB_LOCAL_PATH $CB_DOWNLOAD_URL && \
    sudo dpkg -i $CB_LOCAL_PATH && \
    sudo rm $CB_LOCAL_PATH && \
    sudo service couchbase-server stop

# add startup script, make it executable

ADD startup.sh /home/user/startup.sh
RUN sudo chmod +x /home/user/startup.sh

#expose 8091 port to enable access to Couchbase web interface

EXPOSE 8091
ENV CODENVY_APP_PORT_8091_HTTP 8091

# run Couchbase, create test_bucket and execute JAR

CMD sudo /home/user/startup.sh
