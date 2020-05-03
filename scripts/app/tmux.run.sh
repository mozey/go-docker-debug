#!/usr/bin/env bash
set -eu # exit on error or undefined variable
bash -c 'set -o pipefail' # return code of first cmd to fail in a pipeline

NAME="go-docker-debug"

tmux send -t ${NAME} "/mnt/go-docker-debug/scripts/app/build.dev.sh" ENTER
tmux send -t ${NAME} "/mnt/go-docker-debug/scripts/app/debug.sh" ENTER


