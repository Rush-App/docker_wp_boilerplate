#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

export DOCKER_ROOT_DIRECTORY="$(cd "$SCRIPT_DIR/../" && pwd)"

export PATH_TO_DOCKER_ENV_FILE="$DOCKER_ROOT_DIRECTORY/.env"
