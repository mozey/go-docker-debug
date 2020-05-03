#!/usr/bin/env bash
set -eu # exit on error or undefined variable
bash -c 'set -o pipefail' # return code of first cmd to fail in a pipeline

APP_DIR=${APP_DIR}
APP_PORT=${APP_PORT}
ADDR=":${APP_PORT}"

echo "building app..."
go build -ldflags "-X main.addr=${ADDR}" \
-o ${APP_DIR}/dev.out ${APP_DIR}/main.go
