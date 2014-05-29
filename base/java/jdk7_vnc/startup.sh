#! /bin/bash

sudo /usr/bin/supervisord -c /opt/supervisord.conf

exec "$@"
