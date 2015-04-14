FROM codenvy/jdk7_tomee

$debug?EXPOSE 8000:$
$debug?ENV CODENVY_APP_PORT_8000_DEBUG 8000:$
$debug?CMD ./catalina.sh jpda run 2>&1:$

ENV CODENVY_APP_BIND_DIR /home/user/tomee/webapps/ROOT
VOLUME ["/home/user/tomee/webapps/ROOT"]
