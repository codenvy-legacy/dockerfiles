FROM codenvy/jdk7

RUN sudo apt-get update && \
    sudo apt-get install -y python

RUN cd /home/user && \
    wget -q "http://downloads.typesafe.com/play/1.2.7/play-1.2.7.zip" && \
    unzip -q play-1.2.7.zip && \
    rm play-1.2.7.zip

ENV PATH $PATH:/home/user/play-1.2.7/

EXPOSE 9000

CMD play run /home/user/application

# ===== Usage =====
# FROM codenvy/jdk7_play1
# ADD $app$ /home/user/application.zip
# RUN unzip application.zip -d application && \
#     rm -rf application.zip
