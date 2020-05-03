#!/usr/bin/env bash
set -eu # exit on error or undefined variable
bash -c 'set -o pipefail' # return code of first cmd to fail in a pipeline

APP_DIR=${APP_DIR}
PORT=${PORT}
SSH=${SSH}
DELVE=${DELVE}

NAME="go-docker-debug"

# Stop container if running
if [[ $(docker ps -f "name=${NAME}" -q) ]]; then
    echo "stopping container..."
    docker stop ${NAME}
else
    echo "container not running"
fi

# Remove container if exists
if [[ $(docker ps -a -f "name=${NAME}" -q) ]]; then
    echo "removing container..."
    docker rm ${NAME}
else
    echo "container does not exist"
fi

# Create container
echo "creating container..."
docker create --name "${NAME}" \
    -p ${PORT}:8118 -p ${SSH}:22 -p ${DELVE}:2345 \
    -v ${APP_DIR}:/mnt/go-docker-debug \
    ${NAME}
