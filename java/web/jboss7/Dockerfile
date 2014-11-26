FROM codenvy/jdk7_jboss7

$debug?EXPOSE 8000:$
$debug?ENV CODENVY_APP_PORT_8000_DEBUG 8000:$
$debug?ENV JAVA_OPTS "-Xdebug -Xnoagent -Xrunjdwp:transport=dt_socket,address=8000,server=y,suspend=n":$

VOLUME ["/home/user/jboss7/standalone/deployments/ROOT.war"]