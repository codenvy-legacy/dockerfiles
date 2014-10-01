FROM codenvy/jdk7

RUN cd /home/user && \
    wget -q "http://download.java.net/glassfish/4.0/release/glassfish-4.0.zip" && \
    unzip -q glassfish-4.0.zip && \
    rm glassfish-4.0.zip && \
    rm -rf glassfish4/glassfish/domains/domain1/autodeploy/*

EXPOSE 8080
ENV CODENVY_APP_PORT_8080_HTTP 8080

WORKDIR /home/user/glassfish4/bin/

CMD ./asadmin start-domain --verbose

# ===== Usage =====
# FROM codenvy/jdk7_glassfish4
# ADD $app$ /home/user/$app$
# CMD ./asadmin start-domain && \
#     ./asadmin deploy --contextroot "/" /home/user/$app$ && \
#     tail -f /home/user/glassfish4/glassfish/domains/domain1/logs/server.log
# ===== OR (debug) =====
# FROM codenvy/jdk7_glassfish4
# EXPOSE 9009
# ENV CODENVY_APP_PORT_9009_DEBUG 9009
# ADD $app$ /home/user/$app$
# CMD ./asadmin start-domain --debug && \
#     ./asadmin deploy --contextroot "/" /home/user/$app$ && \
#     tail -f /home/user/glassfish4/glassfish/domains/domain1/logs/server.log
