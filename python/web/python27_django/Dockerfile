FROM codenvy/python27

EXPOSE 8000
ENV CODENVY_APP_PORT_8000_HTTP 8000

RUN mkdir /tmp/application /home/user/application

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
    /env/bin/python /home/user/application/$executable:-manage.py$ runserver 0.0.0.0:8000 2>&1