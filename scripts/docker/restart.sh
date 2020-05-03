#!/usr/bin/env bash
set -eu # exit on error or undefined variable
bash -c 'set -o pipefail' # return code of first cmd to fail in a pipeline

APP_NAME=${APP_NAME}
APP_MNT="/mnt/${APP_NAME}"
APP_PORT=${APP_PORT}

# Stop container if running
if [[ $(docker ps -f "name=${APP_NAME}" -q) ]]; then
    echo "stopping container..."
    docker stop ${APP_NAME}
fi

echo "starting container..."
docker start ${APP_NAME}

echo "starting app..."
docker exec -d ${APP_NAME} tmux new -d -s ${APP_NAME}
docker exec -d ${APP_NAME} "${APP_MNT}/scripts/app/tmux.run.sh"

