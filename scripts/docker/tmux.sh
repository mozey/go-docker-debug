#!/usr/bin/env bash
set -eu # exit on error or undefined variable
bash -c 'set -o pipefail' # return code of first cmd to fail in a pipeline

APP_NAME=${APP_NAME}
APP_SSH=${APP_SSH}

ssh -p ${APP_SSH} root@localhost -t tmux attach -t ${APP_NAME}
