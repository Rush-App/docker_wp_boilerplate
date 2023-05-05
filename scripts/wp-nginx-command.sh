#!/bin/bash

if [ "$ENV" = "dev" ]; then
  envsubst '$DOMAIN_NAME' < /etc/nginx/conf.d/wp-app.conf.template > /etc/nginx/conf.d/wp-app.conf &&
  envsubst '$PHP_MY_ADMIN_DOMAIN_NAME' < /etc/nginx/conf.d/phpmyadmin.conf.template > /etc/nginx/conf.d/phpmyadmin.conf &&
  (while :; do sleep 6h & wait ${!}; nginx -s reload; done) & nginx -g 'daemon off;'
elif [ "$ENV" = "prod" ]; then
  envsubst '$DOMAIN_NAME' < /etc/nginx/conf.d/wp-app.conf.template > /etc/nginx/conf.d/wp-app.conf &&
  (while :; do sleep 6h & wait ${!}; nginx -s reload; done) & nginx -g 'daemon off;'
fi
