FROM codenvy/jdk7
RUN sudo apt-get update && sudo apt-get -y install sudo zip
RUN mkdir /home/user/exo && cd /home/user/exo
# Download eXo and unzip it
RUN wget -q http://sourceforge.net/projects/exo/files/Platform4.0/eXo-Platform-community-4.0.5.zip -O /home/user/exo/eXo-Platform-community-4.0.5.zip && \
         unzip -q /home/user/exo/*.zip -d /home/user/exo && \
         rm /home/user/exo/*.zip
# Install eXo as a service
RUN sudo echo -e "case \$1 in\nstart)\n  sh /home/user/exo/platform-community-4.0.5/start_eXo.sh -b\n  ;;\nstop)\n  sh /home/user/exo/platform-community-4.0.5/stop_eXo.sh\n  ;;\nes
ac\nexit 0\n" | sudo tee /etc/init.d/exo && \
    sudo chmod 755 /etc/init.d/exo
EXPOSE 8080
CMD /home/user/exo/platform-community-4.0.5/start_eXo.sh
