FROM codenvy/jdk7

ENV DEBIAN_FRONTEND noninteractive

RUN sudo apt-get update && sudo apt-get install -y curl && \
    echo "deb http://debian.datastax.com/community stable main" | sudo tee -a /etc/apt/sources.list.d/cassandra.sources.list && \
    curl -L http://debian.datastax.com/debian/repo_key | sudo apt-key add - && \
    sudo apt-get update && \
    sudo -E bash -c "apt-get install -y cassandra"

ADD startup.sh /home/user/startup.sh

RUN sudo chmod +x /home/user/startup.sh

EXPOSE 9160

CMD sudo /home/user/startup.sh