FROM codenvy/jdk7

RUN cd /home/user && \
    wget -q "http://ftp.fau.de/eclipse/virgo/release/VP/3.6.3.RELEASE/virgo-tomcat-server-3.6.3.RELEASE.zip" && \
    unzip -q virgo-tomcat-server-3.6.3.RELEASE.zip && \
    rm virgo-tomcat-server-3.6.3.RELEASE.zip && \
    mv virgo-tomcat-server-3.6.3.RELEASE virgo && \
    rm -rf virgo/pickup/*

EXPOSE 8080
ENV CODENVY_APP_PORT_8080_HTTP 8080

WORKDIR /home/user/virgo/bin

CMD ./startup.sh

# ===== Usage =====
# FROM codenvy/jdk7_virgo
# ADD $app$ /home/user/virgo/pickup/ROOT.war
# ===== OR (debug) =====
# FROM codenvy/jdk7_virgo
# EXPOSE 8000
# ENV CODENVY_APP_PORT_8000_DEBUG 8000
# CMD ./startup.sh -debug
# ADD $app$ /home/user/virgo/pickup/ROOT.war
