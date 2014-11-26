FROM codenvy/jdk7_glassfish4

$debug?EXPOSE 9009:$
$debug?ENV CODENVY_APP_PORT_9009_DEBUG 9009:$

CMD ./asadmin start-domain $debug?--debug:$ && \
    ./asadmin deploydir --contextroot "/" /home/user/application && \
    tail -f /home/user/glassfish4/glassfish/domains/domain1/logs/server.log

VOLUME ["/home/user/application"]


