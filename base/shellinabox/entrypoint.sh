#! /bin/bash

set -e

sudo /opt/shellinabox/shellinaboxd -b --no-beep --service /:LOGIN

exec "$@"
