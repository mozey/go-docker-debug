#!/usr/bin/env bash

NAME="go-docker-debug"

tmux send -t ${NAME} "/usr/local/go/bin/go run -ldflags \"-X main.addr=:8118\" /mnt/app/main.go" ENTER
