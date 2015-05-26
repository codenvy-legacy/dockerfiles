FROM codenvy/python27
RUN wget -qO- "https://storage.googleapis.com/appengine-sdks/deprecated/1919/google_appengine_1.9.19.zip" -O /tmp/gae-sdk.zip && \
    unzip -q /tmp/gae-sdk.zip -d /home/user && \
    rm /tmp/gae-sdk.zip
EXPOSE 8080
ENV CODENVY_APP_PORT_8080_HTTP 8080
RUN mkdir /home/user/app
CMD /home/user/google_appengine/dev_appserver.py 2>&1 --host 0.0.0.0 --skip_sdk_update_check true /home/user/app
