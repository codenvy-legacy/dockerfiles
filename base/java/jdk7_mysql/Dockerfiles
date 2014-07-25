FROM codenvy/jdk7

ENV DEBIAN_FRONTEND noninteractive

RUN sudo apt-get update && \
    sudo apt-get install pwgen && \
    CODENVY_MYSQL_PASSWORD=$(pwgen -N 1) && \
    CODENVY_MYSQL_DB=testdb_$(pwgen -N 1) && \
    CODENVY_MYSQL_USER=root && \
    echo "export CODENVY_MYSQL_PASSWORD=$CODENVY_MYSQL_PASSWORD" >> /home/user/.mysqlrc && \
    echo "export CODENVY_MYSQL_USER=$CODENVY_MYSQL_USER" >> /home/user/.mysqlrc && \
    echo "export CODENVY_MYSQL_DB=$CODENVY_MYSQL_DB" >> /home/user/.mysqlrc && \
    echo "mysql-server mysql-server/root_password password $CODENVY_MYSQL_PASSWORD" | sudo debconf-set-selections && \
    echo "mysql-server mysql-server/root_password_again password $CODENVY_MYSQL_PASSWORD" | sudo debconf-set-selections && \
    sudo -E bash -c "apt-get -y --no-install-recommends install mysql-server" && \
    sudo service mysql restart && \
    sudo mysql -u$CODENVY_MYSQL_USER -p$CODENVY_MYSQL_PASSWORD -e "GRANT ALL PRIVILEGES ON *.* TO '$CODENVY_MYSQL_USER'@'%' IDENTIFIED BY '"$CODENVY_MYSQL_PASSWORD"'; FLUSH PRIVILEGES;" && \
    sudo mysql -u$CODENVY_MYSQL_USER -p$CODENVY_MYSQL_PASSWORD -e "CREATE DATABASE $CODENVY_MYSQL_DB;"

ADD startup.sh /home/user/startup.sh

RUN sudo chmod +x /home/user/startup.sh

EXPOSE 3306

CMD sudo /home/user/startup.sh