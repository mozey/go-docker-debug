#!/usr/bin/env bash
set -eu # exit on error or undefined variable
bash -c 'set -o pipefail' # return code of first cmd to fail in a pipeline

APP_DIR=${APP_DIR}

echo "starting dlv..."
dlv exec --headless --listen=:2345 --continue --accept-multiclient \
--api-version=2 ${APP_DIR}/dev.out
