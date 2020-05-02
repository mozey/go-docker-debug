#!/usr/bin/env bash

echo "building app..."
go build -ldflags "-X main.addr=:8118" -o /mnt/go-docker-debug/dev.out /mnt/go-docker-debug/main.go
