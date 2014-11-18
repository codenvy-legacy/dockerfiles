FROM codenvy/python27

RUN wget -qO- "https://storage.googleapis.com/appengine-sdks/featured/google_appengine_1.9.15.zip" -O /tmp/gae-sdk.zip && \
    unzip -qq /tmp/gae-sdk.zip -d /home/user && \
    rm /tmp/gae-sdk.zip

EXPOSE 8080
ENV CODENVY_APP_PORT_8080_HTTP 8080

RUN mkdir /tmp/application
RUN mkdir /home/user/application

VOLUME ["/home/user/application"]

ADD $app$/requirements.txt /tmp/application/requirements.txt

RUN cd /tmp/application && \
    sudo virtualenv /env && \
    sudo /env/bin/pip install -r requirements.txt -t /tmp/application/lib

# 1. Copy libs to the application folder
# 2. Update permissions recursively
# 3. Make newly created files accessible for anyone
# 4. Start application
CMD sudo cp -a /tmp/application/lib /home/user/application/ && \
    sudo chmod a+rw -R /home/user/application/ && \
    umask 0 && \
    /env/bin/python /home/user/google_appengine/dev_appserver.py --host 0.0.0.0 --skip_sdk_update_check true /home/user/application
