#!/usr/bin/env bash

NAME="go-docker-debug"

tmux send -t ${NAME} "/mnt/go-docker-debug/scripts/app/build.sh" ENTER
tmux send -t ${NAME} "/mnt/go-docker-debug/scripts/app/debug.sh" ENTER


