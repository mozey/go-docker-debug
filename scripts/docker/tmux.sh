#!/usr/bin/env bash
set -eu # exit on error or undefined variable
bash -c 'set -o pipefail' # return code of first cmd to fail in a pipeline

NAME="go-docker-debug"

ssh -p 8119 root@localhost -t tmux attach -t ${NAME}
