FROM codenvy/jdk7_tomcat7

$debug?EXPOSE 8000:$
$debug?ENV CODENVY_APP_PORT_8000_DEBUG 8000:$
$debug?CMD ./catalina.sh jpda run 2>&1:$

VOLUME ["/home/user/tomcat7/webapps/ROOT"]
