FROM codenvy/jdk7_glassfish4

$debug?EXPOSE 9009:$
$debug?ENV CODENVY_APP_PORT_9009_DEBUG 9009:$

CMD ./asadmin start-domain $debug?--debug:$ && \
    ./asadmin deploy --contextroot "/" /home/user/$app$ && \
    tail -f /home/user/glassfish4/glassfish/domains/domain1/logs/server.log

ADD $app$ /home/user/$app$


