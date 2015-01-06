FROM codenvy/shellinabox

ENV DEBIAN_FRONTEND noninteractive
ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2
ENV SITE_DIR /var/www/html

RUN sudo apt-get update && \
    sudo apt-get -y install apache2 php5 php-pear php5-mysql && \
    sudo rm -R $SITE_DIR/* && \
    echo "ServerName localhost" | sudo tee -a /etc/apache2/apache2.conf

# expose and listen to 80 port
EXPOSE 80
ENV CODENVY_APP_PORT_80_HTTP 80


# Install MYSQL
RUN sudo -E bash -c "apt-get -y --no-install-recommends install mysql-server" && \
    sudo sed -i.bak 's/127.0.0.1/0.0.0.0/g' /etc/mysql/my.cnf && \
    sudo service mysql restart && \
    sudo mysql -uroot -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%'; FLUSH PRIVILEGES;"

# Expose 3306 port so that MySQL DB can be accessed from outside
EXPOSE 3306
 
# Create MySQL user and database, and start it
RUN sudo service mysql restart && \
    CODENVY_MYSQL_PASSWORD=test && \
    CODENVY_MYSQL_DB=test && \
    CODENVY_MYSQL_USER=test && \
    echo "MySQL password: $CODENVY_MYSQL_PASSWORD" >> /home/user/.mysqlrc && \
    echo "MySQL user    : $CODENVY_MYSQL_USER" >> /home/user/.mysqlrc && \
    echo "MySQL Database:$CODENVY_MYSQL_DB" >> /home/user/.mysqlrc && \
    sudo mysql -uroot -e "CREATE USER '$CODENVY_MYSQL_USER'@'%' IDENTIFIED BY '"$CODENVY_MYSQL_PASSWORD"'" && \
    sudo mysql -uroot -e "GRANT ALL PRIVILEGES ON *.* TO '$CODENVY_MYSQL_USER'@'%' IDENTIFIED BY '"$CODENVY_MYSQL_PASSWORD"'; FLUSH PRIVILEGES;" && \
    sudo mysql -uroot -e "CREATE DATABASE $CODENVY_MYSQL_DB;"

# start container

CMD sudo chown -R www-data:www-data $SITE_DIR/ && \
    sudo chmod -R 777 $SITE_DIR && \
    sudo service mysql start > /dev/null && \
    sudo service apache2 start && \
    sudo tail -f $APACHE_LOG_DIR/access.log -f $APACHE_LOG_DIR/error.log
