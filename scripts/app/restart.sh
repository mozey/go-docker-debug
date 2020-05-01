#!/usr/bin/env bash

# Set (e) exit on error
# Set (u) no-unset to exit on undefined variable
set -eu
# If any command in a pipeline fails,
# that return code will be used as the
# return code of the whole pipeline.
bash -c 'set -o pipefail'

NAME="go-docker-debug"

# Stop container if running
if [[ $(docker ps -f "name=${NAME}" -q) ]]; then
    echo "stopping container..."
    docker stop ${NAME}
fi

echo "starting container..."
docker start ${NAME}

echo "starting app..."
docker exec -d ${NAME} tmux new -d -s ${NAME}
docker exec -d ${NAME} /mnt/app/scripts/app/build.tmux.sh

