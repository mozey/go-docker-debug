#!/usr/bin/env sh
cd /
go run -ldflags "-X main.addr=:8118" main.go
