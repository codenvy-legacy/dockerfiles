FROM codenvy/debian_jre

ENV GAE /home/user/google_appengine

RUN sudo apt-get update -y && \
    sudo apt-get install --no-install-recommends -y -q build-essential python3 python3-dev python-pip git python3-pip && \
    sudo pip3 install -U pip && \
    sudo pip3 install virtualenv
RUN wget -qO- "https://storage.googleapis.com/appengine-sdks/featured/google_appengine_1.9.37.zip" -O /tmp/gae-sdk.zip && \
    unzip -q /tmp/gae-sdk.zip -d /home/user && \
    rm /tmp/gae-sdk.zip

EXPOSE 8080 8000
CMD tailf /dev/null
WORKDIR /projects
