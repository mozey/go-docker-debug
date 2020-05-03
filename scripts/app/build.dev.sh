#!/usr/bin/env bash
set -eu # exit on error or undefined variable
bash -c 'set -o pipefail' # return code of first cmd to fail in a pipeline

echo "building app..."
go build -ldflags "-X main.addr=:8118" -o /mnt/go-docker-debug/dev.out /mnt/go-docker-debug/main.go
