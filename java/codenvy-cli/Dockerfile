FROM codenvy/jdk7

ENV CLI_HOME /home/user/application

RUN mkdir $CLI_HOME

VOLUME ["/home/user/application"]

# 1. Build application is unpacked zip archive, so move zip content into application dir
# 2. Remove unnecessary empty unzipped folder
# 3. Make main CLI scripts executable
# 4. Allow CLI starts automatically when shell opens
# 5. Disallow image stop automatically
CMD mv $CLI_HOME/codenvy-cli-*/* $CLI_HOME && \
    rm -R $CLI_HOME/codenvy-cli-* && \
    chmod +x $CLI_HOME/bin/* && \
    echo "$CLI_HOME/bin/codenvy-cli" >> /home/user/.bashrc && \
    while true;do true; done
