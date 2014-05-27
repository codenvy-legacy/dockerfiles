#!/bin/bash

mkdir /var/run/sshd

# create an ubuntu user
PASS=`pwgen -c -n -1 10`
PASS=debian
echo "User: debian Pass: $PASS"
useradd --create-home --shell /bin/bash --user-group --groups adm,sudo debian
echo "debian:$PASS" | chpasswd

cp /tmp/application.jar /home/debian/application.jar

/usr/bin/supervisord -c /supervisord.conf

while [ 1 ]; do
    /bin/bash
done
