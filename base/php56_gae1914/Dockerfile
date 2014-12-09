FROM codenvy/python27
RUN cd /home/user/ && wget -q https://storage.googleapis.com/appengine-sdks/deprecated/1914/google_appengine_1.9.14.zip && \
    unzip -q google_appengine_1.9.14.zip && \
    rm google_appengine_1.9.14.zip && \
    sudo apt-get update -y && \
    sudo apt-get -y install --no-install-recommends php5 php5-cgi
ENV CODENVY_APP_PORT_8080_HTTP 8080
EXPOSE 8080
WORKDIR /home/user/google_appengine
CMD ./dev_appserver.py 2>&1 --php_executable_path=/usr/bin/php5-cgi --skip_sdk_update_check true --host=0.0.0.0 /home/user/app
