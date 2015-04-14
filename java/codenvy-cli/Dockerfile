FROM codenvy/jdk7

RUN mkdir /home/user/application

ENV CODENVY_APP_BIND_DIR /home/user/application

VOLUME ["/home/user/application"]

# 1. Build application is unpacked zip archive, so move zip content into application dir
# 2. Remove unnecessary empty unzipped folder
# 3. Make main CLI scripts executable
# 4. Allow CLI starts automatically when shell opens
# 5. Disallow image stop automatically
CMD mv /home/user/application/codenvy-cli-*/* /home/user/application && \
    rm -R /home/user/application/codenvy-cli-* && \
    sudo chmod +x /home/user/application/bin/* && \
    echo "/home/user/application/bin/codenvy-cli" >> /home/user/.bashrc && \
    while true;do true; done
