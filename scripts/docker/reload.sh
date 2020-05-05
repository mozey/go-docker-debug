#!/usr/bin/env bash
set -eu # exit on error or undefined variable
bash -c 'set -o pipefail' # return code of first cmd to fail in a pipeline

APP_NAME=${APP_NAME}
APP_MNT="/mnt/${APP_NAME}"
APP_PORT=${APP_PORT}

# Stop server
# TODO C-c (or C-d) doesn't stop dlv?
#docker exec -d ${APP_NAME} \
#    tmux send-keys -t ${APP_NAME} C-c
# Not ideal, a new tmux session must be created
#docker exec -d ${APP_NAME} tmux kill-session -t ${APP_NAME}
docker exec -d ${APP_NAME} pkill dlv
docker exec -d ${APP_NAME} pkill dev.out

# Start server
docker exec -d ${APP_NAME} "${APP_MNT}/scripts/docker/run.sh"
