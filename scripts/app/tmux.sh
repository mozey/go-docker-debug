#!/usr/bin/env bash

NAME="go-docker-debug"

ssh -p 8119 root@localhost -t tmux attach -t ${NAME}
