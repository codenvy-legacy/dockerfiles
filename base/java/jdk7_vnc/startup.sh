#!/bin/bash

mkdir /var/run/sshd

/usr/bin/supervisord -c /supervisord.conf

while [ 1 ]; do
    /bin/bash
done
