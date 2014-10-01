FROM codenvy/shellinabox

ENV DEBIAN_FRONTEND noninteractive
ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2
ENV SITE_DIR /var/www/html

RUN sudo apt-get update && \
    sudo -E apt-get install -y apache2 php5 libapache2-mod-php5 curl php5-curl && \
    sudo rm -R $SITE_DIR/* && \
    echo "ServerName localhost" | sudo tee -a /etc/apache2/apache2.conf

EXPOSE 80
ENV CODENVY_APP_PORT_80_HTTP 80

CMD sudo chown -R www-data:www-data $SITE_DIR/ && \
    sudo chmod -R 777 $SITE_DIR && \
    sudo service apache2 start && \
    sudo tail -f $APACHE_LOG_DIR/access.log -f $APACHE_LOG_DIR/error.log