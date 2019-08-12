#!/bin/sh
set -e

sed -i "s#FASTCGI_PASS#${FASTCGI_PASS}#" /etc/nginx/conf.d/default.conf
sed -i "s#LARAVEL_ECHO_SERVER_URL#${LARAVEL_ECHO_SERVER_URL}#" /etc/nginx/conf.d/default.conf

exec "$@"
