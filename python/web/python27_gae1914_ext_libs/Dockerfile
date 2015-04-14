FROM codenvy/python27_gae1914

RUN mkdir /tmp/application

ENV CODENVY_APP_BIND_DIR /home/user/application

VOLUME ["/home/user/application"]

ADD $app$/requirements.txt /tmp/application/requirements.txt

RUN cd /tmp/application && \
    sudo virtualenv /env && \
    sudo /env/bin/pip install -r requirements.txt -t /tmp/application/lib

CMD sudo cp -a /tmp/application/lib /home/user/application/ && \
    sudo chmod a+rw -R /home/user/application/ && \
    umask 0 && \
    /home/user/google_appengine/dev_appserver.py 2>&1 --host 0.0.0.0 --skip_sdk_update_check true /home/user/application