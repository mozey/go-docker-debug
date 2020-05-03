#!/usr/bin/env bash
set -eu # exit on error or undefined variable
bash -c 'set -o pipefail' # return code of first cmd to fail in a pipeline

NAME="go-docker-debug"

# Stop server
# TODO C-c (or C-d) doesn't stop dlv?
#docker exec -d ${NAME} \
#    tmux send-keys -t ${NAME} C-c
# Not ideal, a new tmux session must be created
#docker exec -d ${NAME} tmux kill-session -t ${NAME}
docker exec -d ${NAME} pkill dlv
docker exec -d ${NAME} pkill dev.out

# Start server
docker exec -d ${NAME} "/mnt/${NAME}/scripts/app/tmux.run.sh"
