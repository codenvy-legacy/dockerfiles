FROM codenvy/jdk7

RUN apt-get install unzip

RUN cd /opt && \
    wget -q "http://download.java.net/glassfish/4.0/release/glassfish-4.0.zip" && \
    unzip -q glassfish-4.0.zip && \
    rm glassfish-4.0.zip && \
    rm -rf glassfish4/glassfish/domains/domain1/autodeploy/*

EXPOSE 8080

WORKDIR /opt/glassfish4/bin/

CMD ./asadmin start-domain --verbose

# ===== Usage =====
# FROM codenvy/jdk7_glassfish4
# ADD $app$ /opt/$app$
# CMD ./asadmin start-domain && \
#     ./asadmin deploy --contextroot "/" /opt/$app$ && \
#     tail -f /opt/glassfish4/glassfish/domains/domain1/logs/server.log
# ===== OR (debug) =====
# FROM codenvy/jdk7_glassfish4
# EXPOSE 9009
# ADD $app$ /opt/$app$
# CMD ./asadmin start-domain --debug && \
#     ./asadmin deploy --contextroot "/" /opt/$app$ && \
#     tail -f /opt/glassfish4/glassfish/domains/domain1/logs/server.log
