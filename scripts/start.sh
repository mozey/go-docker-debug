#!/usr/bin/env bash
set -eu # exit on error or undefined variable
bash -c 'set -o pipefail' # return code of first cmd to fail in a pipeline

NAME="go-docker-debug"
if [[ $(tmux ls | grep ${NAME}) ]]; then
    echo "stop session..."
    tmux send-keys -t ${NAME} C-c
fi
echo "new session..."
tmux new-session -d -s ${NAME} make app
echo "done"
