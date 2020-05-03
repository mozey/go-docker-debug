#!/usr/bin/env bash
set -eu # exit on error or undefined variable
bash -c 'set -o pipefail' # return code of first cmd to fail in a pipeline

APP_NAME=${APP_NAME}
APP_PORT=${APP_PORT}

REBUILD_BASE="false"
read -r -p "Rebuild base image? Might take a while! [y/N] " response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]
then
    REBUILD_BASE="true"
fi

# Stop container if running
if [[ $(docker ps -f "name=${APP_NAME}" -q) ]]; then
    echo "stopping container..."
    docker stop ${APP_NAME}
else
    echo "container not running"
fi

# Remove container if exists
if [[ $(docker ps -a -f "name=${APP_NAME}" -q) ]]; then
    echo "removing container..."
    docker rm ${APP_NAME}
else
    echo "container does not exist"
fi

# Remove image if exists
if [[ $(docker image ls | grep ${APP_NAME} | grep -v base) ]]; then
    echo "removing image..."
    docker image rm ${APP_NAME}
else
    echo "image does not exist"
fi

# Base image
if [[ $(docker image ls | grep "${APP_NAME}-base") ]]; then
    if [[ ${REBUILD_BASE} == "true" ]]; then
        echo "removing base image..."
        docker image rm "${APP_NAME}-base"
    fi
else
    echo "base image does not exist"
    REBUILD_BASE="true"
fi
if [[ ${REBUILD_BASE} == "true" ]]; then
    echo "building base image..."
    docker build -t "${APP_NAME}-base" \
        -f ./scripts/docker/base/Dockerfile --rm \
        ./scripts/docker/base
fi

# Build image
echo "building image..."
docker build -t "${APP_NAME}" \
    --build-arg APP_NAME=${APP_NAME} \
    --build-arg APP_PORT=${APP_PORT} \
    -f ./scripts/docker/app/Dockerfile --rm \
    ./scripts/docker/app

echo "done"
