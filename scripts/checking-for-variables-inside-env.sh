#!/bin/bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
source "$SCRIPT_DIR/constants.sh"

# Check if all variables are set in .env file
if [ -f "$PATH_TO_DOCKER_ENV_FILE" ]; then
  source "$PATH_TO_DOCKER_ENV_FILE"
  if [[ -z "${ENV}" || -z "${DB_ENV_PATH}" || -z "${DB_VOLUME}" || -z "${NGINX_CONF_D_VOLUME}" ||
    -z "${NGINX_MAIN_CONF_VOLUME}" || -z "${LETSENCRYPT_VOLUME}" || -z "${CERTBOT_VOLUME}" ||
    -z "${PHP_MY_ADMIN_DOMAIN_NAME}" || -z "${DOMAIN_NAME}"
  ]]; then
    echo "ERROR: all variables are not set in the .env file."
  fi
else
  echo "CRITICAL ERROR: .env file not found."
  echo "Please create a .env file with the necessary variables."
  exit 1
fi
