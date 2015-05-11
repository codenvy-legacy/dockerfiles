FROM codenvy/jdk7_gae1914
ENV CODENVY_APP_BIND_DIR /home/user/app
VOLUME ["/home/user/app/"]
$debug?EXPOSE 8000:$
$debug?ENV CODENVY_APP_PORT_8000_DEBUG 8000:$
$debug?CMD ./dev_appserver.sh 2>&1 --disable_update_check --jvm_flag=-Xdebug --jvm_flag=-Xrunjdwp:transport=dt_socket,address=8000,server=y,suspend=n -a 0.0.0.0 /home/user/app:$
