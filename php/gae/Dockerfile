FROM codenvy/php
ENV GAE /home/user/google_appengine

RUN sudo apt-get update && \
    sudo apt-get install --no-install-recommends -y -q build-essential python2.7 python2.7-dev python-pip && \
    sudo pip install -U pip && \
    sudo pip install virtualenv
RUN cd /home/user/ && wget -q https://storage.googleapis.com/appengine-sdks/featured/google_appengine_1.9.37.zip && \
    unzip -q google_appengine_1.9.37.zip && \
    rm google_appengine_1.9.37.zip 

EXPOSE 8080 8000
WORKDIR /projects
