FROM codenvy/jdk7

ENV DEBIAN_FRONTEND noninteractive

RUN wget -O - http://debian.neo4j.org/neotechnology.gpg.key | sudo apt-key add - && \
    echo "deb http://debian.neo4j.org/repo stable/" | sudo tee /etc/apt/sources.list.d/neo4j.list && \
    sudo apt-get update && \
    sudo -E bash -c "apt-get -y install neo4j"

ADD startup.sh /home/user/startup.sh

RUN sudo chmod +x /home/user/startup.sh

CMD sudo /home/user/startup.sh