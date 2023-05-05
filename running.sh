#!/bin/bash

set -e  # Exit immediately if a command exits with a non-zero status code

chmod +x scripts/*.sh

./scripts/is-docker-installed.sh
./scripts/prepare-docker-env-file.sh
./scripts/is-urls-in-hosts-file.sh

source .env

if [ "$ENV" = "dev" ]; then
    docker-compose --profile dev up --build
fi

if [ "$ENV" = "prod" ]; then
    docker-compose --profile prod up --build
fi
