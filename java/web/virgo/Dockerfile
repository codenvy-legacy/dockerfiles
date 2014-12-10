FROM codenvy/jdk7_virgo

$debug?EXPOSE 8000:$
$debug?ENV CODENVY_APP_PORT_8000_DEBUG 8000:$
$debug?CMD ./startup.sh -debug:$

VOLUME ["/home/user/virgo/pickup/ROOT.war"]