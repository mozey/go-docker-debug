#!/usr/bin/env bash
set -eu # exit on error or undefined variable
bash -c 'set -o pipefail' # return code of first cmd to fail in a pipeline

APP_NAME=${APP_NAME}

if [[ $(tmux ls | grep ${APP_NAME}) ]]; then
    echo "stop session..."
    tmux send-keys -t ${APP_NAME} C-c
fi
echo "new session..."
tmux new-session -d -s ${APP_NAME} make app
echo "done"
