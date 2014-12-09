FROM codenvy/python27_gae1914

RUN mkdir /tmp/application

VOLUME ["/home/user/app"]

ADD $app$/requirements.txt /tmp/application/requirements.txt

RUN cd /tmp/application && \
    sudo virtualenv /env && \
    sudo /env/bin/pip install -r requirements.txt -t /tmp/application/lib

RUN sudo cp -a /tmp/application/lib /home/user/app/ && \
    sudo chmod a+rw -R /home/user/app/ && \
    umask 0
