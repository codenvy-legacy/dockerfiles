FROM codenvy/python27

RUN wget -qO- "https://storage.googleapis.com/appengine-sdks/featured/google_appengine_1.9.9.zip" -O /tmp/gae-sdk.zip && \
    unzip -qq /tmp/gae-sdk.zip -d /home/user && \
    rm /tmp/gae-sdk.zip

ADD $app$ /home/user/$app$
RUN unzip -q /home/user/$app$ -d /home/user && \
    sudo virtualenv /env && \
    if [ -f /home/user/requirements.txt ]; then sudo /env/bin/pip install -r /home/user/requirements.txt -t /home/user/lib; fi

EXPOSE 8080

CMD /env/bin/python /home/user/google_appengine/dev_appserver.py --host 0.0.0.0 --skip_sdk_update_check true /home/user