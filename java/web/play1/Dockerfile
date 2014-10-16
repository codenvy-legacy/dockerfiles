FROM codenvy/jdk7_play1
ADD $app$ /home/user/application.zip
RUN cd /home/user/ && unzip application.zip -d application && \
    rm -rf application.zip