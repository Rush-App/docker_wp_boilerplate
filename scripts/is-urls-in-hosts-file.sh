#!/bin/bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
source "$SCRIPT_DIR/constants.sh"

# Check if running on Windows
if [[ "$OSTYPE" == "msys"* || "$OSTYPE" == "win"* ]]; then
  HOSTS_FILE="C:\Windows\System32\drivers\etc\hosts"
else
  HOSTS_FILE="/etc/hosts"
fi

# Check if DOMAIN_NAME and PHP_MY_ADMIN_DOMAIN_NAME is set in .env file
if [ -f "$PATH_TO_DOCKER_ENV_FILE" ]; then
  source "$PATH_TO_DOCKER_ENV_FILE"
  if [[ -z "${DOMAIN_NAME}" || -z "${PHP_MY_ADMIN_DOMAIN_NAME}" ]]; then
    echo "ERROR: DOMAIN_NAME or PHP_MY_ADMIN_DOMAIN_NAME is not set in the .env file."
  fi
else
  echo "CRITICAL ERROR: .env file not found."
  echo "Please create a .env file with the necessary variables."
  exit 1
fi

# Check if DOMAIN_NAME  is present in hosts file
if grep -q "$DOMAIN_NAME" "$HOSTS_FILE"; then
  echo "DOMAIN_NAME already exists in hosts file."
else
  # Prompt the user if they want to add the DOMAIN_NAME to hosts file
  read -p "Do you want to add the DOMAIN_NAME to the hosts file? (Y/n) " choice
  if [[ $choice =~ ^[Yy]$ ]]; then
    echo "Adding DOMAIN_NAME to hosts file."
    echo "127.0.0.1 $DOMAIN_NAME" | sudo tee -a "$HOSTS_FILE" > /dev/null
  else
    echo "Please add the DOMAIN_NAME to the hosts file manually."
  fi
fi

# Check if PHP_MY_ADMIN_DOMAIN_NAME  is present in hosts file
if grep -q "$PHP_MY_ADMIN_DOMAIN_NAME" "$HOSTS_FILE"; then
  echo "PHP_MY_ADMIN_DOMAIN_NAME already exists in hosts file."
else
  # Prompt the user if they want to add the PHP_MY_ADMIN_DOMAIN_NAME to hosts file
  read -p "Do you want to add the PHP_MY_ADMIN_DOMAIN_NAME to the hosts file? (Y/n) " choice
  if [[ $choice =~ ^[Yy]$ ]]; then
    echo "Adding PHP_MY_ADMIN_DOMAIN_NAME to hosts file."
    echo "127.0.0.1 $PHP_MY_ADMIN_DOMAIN_NAME" | sudo tee -a "$HOSTS_FILE" > /dev/null
  else
    echo "Please add the PHP_MY_ADMIN_DOMAIN_NAME to the hosts file manually."
  fi
fi

