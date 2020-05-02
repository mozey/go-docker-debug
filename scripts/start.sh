#!/usr/bin/env bash
NAME="go-docker-debug"
if [[ $(tmux ls | grep ${NAME}) ]]; then
    echo "stop session..."
    tmux send-keys -t ${NAME} C-c
fi
echo "new session..."
tmux new-session -d -s ${NAME} make app
echo "done"
