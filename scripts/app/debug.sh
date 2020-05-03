#!/usr/bin/env bash
set -eu # exit on error or undefined variable
bash -c 'set -o pipefail' # return code of first cmd to fail in a pipeline

echo "starting dlv..."
dlv exec --headless --listen=:2345 --continue --accept-multiclient \
--api-version=2 /mnt/go-docker-debug/dev.out
