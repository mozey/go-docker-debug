#!/usr/bin/env bash
set -eu # exit on error or undefined variable
bash -c 'set -o pipefail' # return code of first cmd to fail in a pipeline

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
if [[ $(docker image ls | grep ${NAME} | grep -v base) ]]; then
    echo "removing image..."
    docker image rm ${NAME}
else
    echo "image does not exist"
fi

# Base image
if [[ $(docker image ls | grep "${NAME}-base") ]]; then
    if [[ ${REBUILD_BASE} == "true" ]]; then
        echo "removing base image..."
        docker image rm "${NAME}-base"
    fi
else
    echo "base image does not exist"
    REBUILD_BASE="true"
fi
if [[ ${REBUILD_BASE} == "true" ]]; then
    echo "building base image..."
    docker build -t "${NAME}-base" \
        -f ./scripts/docker/base/Dockerfile --rm \
        ./scripts/docker/base
fi

# Build image
echo "building image..."
docker build -t "${NAME}" \
    -f ./scripts/docker/app/Dockerfile --rm \
    ./scripts/docker/app

echo "done"
