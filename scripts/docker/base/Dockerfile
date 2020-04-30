#FROM golang:1.14-alpine
# docker image ls | grep go-docker-debug
# image         370MB
# docker container ls -a -s | grep go-docker-debug
# container     5.46MB      (virtual 375MB)

#FROM golang:1.14-buster
# image         809MB
# container     5.46MB      (virtual 815MB)

FROM phusion/baseimage:0.11

# Set env vars for build
# [environment-variables](https://vsupalov.com/docker-build-pass-environment-variables)
ENV DEBIAN_FRONTEND "noninteractive"

# Apt
RUN apt-get -y update
#RUN apt-get -y upgrade

# Golang
RUN curl -O https://dl.google.com/go/go1.14.2.linux-amd64.tar.gz
#RUN sha256sum go1.14.2.linux-amd64.tar.gz # TODO Verify the tarball
RUN tar -xf go1.14.2.linux-amd64.tar.gz
RUN chown -R root:root ./go
RUN mv go /usr/local
# Workspace
RUN mkdir /root/go
# Set paths
ENV GOPATH "/root/go"

# Dependencies
RUN apt-get install -yq git --fix-missing

# Delve
RUN /usr/local/go/bin/go get github.com/derekparker/delve/cmd/dlv
