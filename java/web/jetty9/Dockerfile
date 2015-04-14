FROM codenvy/jdk7_jetty9

$debug?EXPOSE 8000:$
$debug?ENV CODENVY_APP_PORT_8000_DEBUG 8000:$
$debug?CMD java -Xdebug -agentlib:jdwp=transport=dt_socket,address=8000,server=y,suspend=n -jar start.jar 2>&1:$

ENV CODENVY_APP_BIND_DIR /home/user/jetty9/webapps/ROOT

VOLUME ["/home/user/jetty9/webapps/ROOT"]
