#! /bin/bash

set -e

sudo ./shellinaboxd -b --no-beep --service /:LOGIN

exec "$@"
