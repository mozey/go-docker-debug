#!/usr/bin/env bash

NAME="go-docker-debug"

# Stop server
docker exec -d ${NAME} \
    tmux send-keys -t ${NAME} C-c

# Start server
docker exec -d ${NAME} /mnt/app/scripts/make.app.sh
