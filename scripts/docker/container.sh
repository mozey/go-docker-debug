#!/usr/bin/env bash
set -eu # exit on error or undefined variable
bash -c 'set -o pipefail' # return code of first cmd to fail in a pipeline

APP_DIR=${APP_DIR}
APP_NAME=${APP_NAME}
APP_PORT=${APP_PORT}
APP_SSH=${APP_SSH}
APP_DELVE=${APP_DELVE}

# Stop container if running
if [[ $(docker ps -f "name=${APP_NAME}" -q) ]]; then
    echo "stopping container..."
    docker stop ${APP_NAME}
else
    echo "container not running"
fi

# Remove container if exists
if [[ $(docker ps -a -f "name=${APP_NAME}" -q) ]]; then
    echo "removing container..."
    docker rm ${APP_NAME}
else
    echo "container does not exist"
fi

# Create container.
# Always use default ports inside the container
echo "creating container..."
docker create --name "${APP_NAME}" \
    -p ${APP_PORT}:${APP_PORT} -p ${APP_SSH}:22 -p ${APP_DELVE}:2345 \
    -v ${APP_DIR}:/mnt/go-docker-debug \
    ${APP_NAME}
