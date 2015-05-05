FROM codenvy/shellinabox

ENV DEBIAN_FRONTEND noninteractive
ENV RUBY_VERSION 2.1.0
RUN sudo apt-get update && \
    sudo -E apt-get install -y nodejs curl && \
    sudo gpg --keyserver hkp://keys.gnupg.net --recv-keys D39DC0E3 && \
    curl -sSL https://get.rvm.io | sudo bash -s stable && \
    sudo /bin/bash -l -c "rvm requirements" && \
    sudo /bin/bash -l -c "rvm install ${RUBY_VERSION}"

RUN sudo sed -i '/exec "$@"/isource /etc/profile.d/rvm.sh\n' /entrypoint.sh
