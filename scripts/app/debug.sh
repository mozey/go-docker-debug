#!/usr/bin/env bash

echo "starting dlv..."
dlv exec --headless --listen=:2345 --continue --accept-multiclient \
--api-version=2 /mnt/go-docker-debug/app.out
