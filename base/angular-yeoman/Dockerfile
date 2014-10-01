FROM codenvy/shellinabox

# install some components
RUN sudo apt-get update && \
    sudo apt-get install -y python git ruby-full rubygems npm && \
    sudo ln -sf /usr/bin/nodejs /usr/bin/node && \
    sudo gem install sass compass && \
    sudo npm install -g yo generator-angular

ENV HOME /home/user 

RUN mkdir /home/user/application /tmp/application
    
# Grunt will listen on 9000 port number
EXPOSE 9000
ENV CODENVY_APP_PORT_9000_HTTP 9000

WORKDIR /home/user/application
