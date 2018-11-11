#!/bin/bash
cd /var/www/html/ && git pull
source /etc/apache2/envvars
tail -F /var/log/apache2/* &
exec apache2ctl -D FOREGROUND