#!/usr/bin/env bash
set -eu # exit on error or undefined variable
bash -c 'set -o pipefail' # return code of first cmd to fail in a pipeline

APP_NAME=${APP_NAME}
APP_MNT="/mnt/${APP_NAME}"
APP_PORT=${APP_PORT}

tmux send -t ${APP_NAME} "export APP_DIR=${APP_MNT}" ENTER
tmux send -t ${APP_NAME} "export APP_PORT=${APP_PORT}" ENTER
tmux send -t ${APP_NAME} "${APP_MNT}/scripts/app/build.dev.sh" ENTER
tmux send -t ${APP_NAME} "${APP_MNT}/scripts/app/debug.sh" ENTER


