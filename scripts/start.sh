#!/usr/bin/env bash
NAME="go-docker-debug"
tmux send-keys -t ${NAME} C-c
tmux new-session -d -s ${NAME} make app
