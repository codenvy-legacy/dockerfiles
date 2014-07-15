#! /bin/bash

set -e

service=$SHELL_IN_A_BOX_SERVICE
theme=$WEB_SHELL_THEME

if [ -z "$service" ]; then
  service="/:user:users:/home/user:/bin/bash"
fi

if [ -z "$theme" ]; then
  theme="DarkTheme"
fi

if [ "$theme" == "DarkTheme" ]; then
  theme="/opt/shellinabox/shellinabox/white-on-black.css"
else  
  theme="/opt/shellinabox/shellinabox/black-on-white.css"
fi

sudo /opt/shellinabox/shellinaboxd -b --css $theme --no-beep --service $service

exec "$@"
