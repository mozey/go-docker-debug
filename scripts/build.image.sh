#!/usr/bin/env bash

# Set (e) exit on error
# Set (u) no-unset to exit on undefined variable
set -eu
# If any command in a pipeline fails,
# that return code will be used as the
# return code of the whole pipeline.
bash -c 'set -o pipefail'

NAME="go-docker-debug"

REBUILD_BASE="false"
read -r -p "Rebuild base image? Might take a while! [y/N] " response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]
then
    REBUILD_BASE="true"
fi

# Stop container if running
if [[ $(docker ps -f "name=${NAME}" -q) ]]; then
    echo "stopping container..."
    docker stop ${NAME}
else
    echo "container not running"
fi

# Remove container if exists
if [[ $(docker ps -a -f "name=${NAME}" -q) ]]; then
    echo "removing container..."
    docker rm ${NAME}
else
    echo "container does not exist"
fi

# Remove image if exists
if [[ $(docker image ls | grep ${NAME}) ]]; then
    echo "removing image..."
    docker image rm ${NAME}
else
    echo "image does not exist"
fi

if [[ ${REBUILD_BASE} == "true" ]]; then
    echo "rebuilding base image..."
    docker build -t "${NAME}-base" \
        -f ./scripts/docker/base/Dockerfile --rm \
        ./docker/base
fi

# Build image
echo "building image..."
docker build -t "${NAME}" \
    -f ./scripts/docker/app/Dockerfile --rm \
    ./docker/app

echo "done"
