FROM codenvy/shellinabox

RUN sudo apt-get update -y && \
    sudo apt-get --no-install-recommends -y -q install git mercurial && \
    sudo mkdir /usr/local/go && wget -qO- https://storage.googleapis.com/golang/go1.3.1.linux-amd64.tar.gz | sudo tar xzf - -C /usr/local/go --strip-components=1 && \
    sudo -E /bin/bash -c "cd /usr/local/go/src && ./make.bash --no-clean &>/dev/null"

ENV PATH $PATH:/usr/local/go/bin