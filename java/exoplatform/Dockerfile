FROM codenvy/jdk7_exo

$debug?EXPOSE 8000:$
$debug?ENV CODENVY_APP_PORT_8000_DEBUG 8000:$
$debug?CMD /home/user/exo/platform-community-4.0.5/start_eXo.sh --debug:$

ADD $app$ /home/user/exo/platform-community-4.0.5/webapps/sample-portlet.war