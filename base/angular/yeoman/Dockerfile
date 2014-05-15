FROM debian:jessie

# install some components
RUN apt-get update && \
    apt-get install -y python git unzip ruby-full rubygems npm && \
    ln -sf /usr/bin/nodejs /usr/bin/node && \
    gem install sass compass && \
    npm install -g yo generator-angular

# 1/ add new user
# 2/ create directory for application
RUN adduser --disabled-password -uid 1000 -gid 100 --home=/home/user --gecos "" user

ENV HOME /home/user 
USER user    

RUN mkdir /home/user/application /tmp/application
    
# Grunt will listen on 9000 port number
EXPOSE 9000

WORKDIR /home/user/application
