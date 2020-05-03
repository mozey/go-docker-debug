#!/usr/bin/env bash
set -eu # exit on error or undefined variable
bash -c 'set -o pipefail' # return code of first cmd to fail in a pipeline

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
docker exec -d ${NAME} /mnt/go-docker-debug/scripts/app/tmux.run.sh

