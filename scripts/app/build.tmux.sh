#!/usr/bin/env bash

NAME="go-docker-debug"

tmux send -t ${NAME} "\\
/mnt/app/scripts/app/build.sh
" ENTER


