FROM codenvy/jdk7_glassfish4
CMD ./asadmin start-domain && \
    ./asadmin deploy --contextroot "/" /home/user/$app$ && \
    tail -f /home/user/glassfish4/glassfish/domains/domain1/logs/server.log
ADD $app$ /home/user/$app$
