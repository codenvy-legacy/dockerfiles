FROM codenvy/python34

EXPOSE 8080
ENV CODENVY_APP_PORT_8080_HTTP 8080

RUN mkdir /tmp/application /home/user/application

ENV CODENVY_APP_BIND_DIR /home/user/application

VOLUME ["/home/user/application"]

ADD $app$/requirements.txt /tmp/application/requirements.txt

RUN cd /tmp/application && \
    sudo virtualenv /env && \
    sudo /env/bin/pip install -r requirements.txt

# 1. Update permissions recursively
# 2. Make newly created files accessible for anyone
# 3. Start application
CMD sudo chmod a+rw -R /home/user/application/ && \
    umask 0 && \
    /env/bin/python /home/user/application/$executable:-main.py$
