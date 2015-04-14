FROM codenvy/jdk7_resin

$debug?EXPOSE 8000:$
$debug?ENV CODENVY_APP_PORT_8000_DEBUG 8000:$
$debug?CMD ./resin.sh console --debug-port 8000:$

ENV CODENVY_APP_BIND_DIR /home/user/resin/webapps/ROOT

VOLUME ["/home/user/resin/webapps/ROOT"]