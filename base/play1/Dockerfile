FROM codenvy/jdk7

RUN sudo apt-get update && \
    sudo apt-get install -y python

RUN cd /home/user && \
    wget -q "http://downloads.typesafe.com/play/1.2.7/play-1.2.7.zip" && \
    unzip -q play-1.2.7.zip && \
    rm play-1.2.7.zip

EXPOSE 9000

WORKDIR /home/user/

ENV PATH $PATH:/home/user/play-1.2.7/

CMD play run /home/user/application

# ===== Usage =====
# FROM codenvy/play1
# ADD $app$ /home/user/application.zip
# RUN unzip application.zip -d application && \
#     rm -rf application.zip
