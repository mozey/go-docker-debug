#!/usr/bin/env bash

NAME="go-docker-debug"

# Stop server
# TODO C-c (or C-d) doesn't stop dlv?
#docker exec -d ${NAME} \
#    tmux send-keys -t ${NAME} C-c
# Not ideal, a new tmux session must be created
#docker exec -d ${NAME} tmux kill-session -t ${NAME}
docker exec -d ${NAME} pkill dlv
docker exec -d ${NAME} pkill app.out

# Start server
docker exec -d ${NAME} /mnt/app/scripts/app/tmux.build.sh
