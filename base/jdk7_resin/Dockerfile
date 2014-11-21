FROM codenvy/jdk7

RUN mkdir /home/user/resin && \
    wget -qO- "http://caucho.com/download/resin-4.0.41.tar.gz" | tar -zx --strip-components=1 -C /home/user/resin && \
    rm -rf /home/user/resin/webapps/*

EXPOSE 8080
ENV CODENVY_APP_PORT_8080_HTTP 8080

WORKDIR /home/user/resin/bin

CMD ./resin.sh console

# ===== Usage =====
# FROM codenvy/jdk7_resin
# ADD $app$ /home/user/resin/webapps/ROOT.war
# ===== OR (debug) =====
# FROM codenvy/jdk7_resin
# EXPOSE 8000
# ENV CODENVY_APP_PORT_8000_DEBUG 8000
# CMD ./resin.sh console --debug-port 8000
# ADD $app$ /home/user/resin/webapps/ROOT.war
