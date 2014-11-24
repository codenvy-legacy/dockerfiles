FROM codenvy/jdk7_resin

$debug?EXPOSE 8000:$
$debug?ENV CODENVY_APP_PORT_8000_DEBUG 8000:$
$debug?CMD ./resin.sh console --debug-port 8000:$

VOLUME ["/home/user/resin/webapps/ROOT"]