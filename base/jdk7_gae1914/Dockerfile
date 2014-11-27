FROM codenvy/jdk7
RUN wget -P /home/user/ -q https://storage.googleapis.com/appengine-sdks/deprecated/1914/appengine-java-sdk-1.9.14.zip && \
    unzip /home/user/appengine-java-sdk-1.9.14.zip && \
    rm /home/user/appengine-java-sdk-1.9.14.zip && \
    mkdir /home/user/app
ENV CODENVY_APP_PORT_8080_HTTP 8080
EXPOSE 8080
WORKDIR /home/user/appengine-java-sdk-1.9.14/bin

# === Usage ===
# FROM codenvy/jdk7_gae1914
# ADD web-java-gae-simple-1.0-SNAPSHOT.war_unpack /home/user/app/
# RUN sudo chown -R user:user /home/user/app/
# CMD ./dev_appserver.sh 2>&1 --disable_update_check -a 0.0.0.0 /home/user/app
