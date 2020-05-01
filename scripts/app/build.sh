#!/usr/bin/env bash

echo "building app..."
go build -ldflags "-X main.addr=:8118" -o /mnt/app/app.out /mnt/app/main.go

echo "starting dlv..."
dlv exec --headless --listen=:2345 --continue --accept-multiclient \
--api-version=2 /mnt/app/app.out
