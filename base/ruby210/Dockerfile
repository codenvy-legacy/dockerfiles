FROM codenvy/shellinabox

ENV DEBIAN_FRONTEND noninteractive

RUN sudo apt-get update && \
    sudo -E apt-get install -y nodejs curl && \
    curl -sSL https://get.rvm.io | sudo bash -s stable && \
    sudo /bin/bash -l -c "rvm requirements" && \
    sudo /bin/bash -l -c "rvm install 2.1.0"

RUN sudo sed -i '/exec "$@"/isource /etc/profile.d/rvm.sh\n' /entrypoint.sh