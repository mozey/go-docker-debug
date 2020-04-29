# Using an image from dockerhub
# https://hub.docker.com/_/golang
# Start with the latest version of Go installed
# and a workspace (GOPATH) configured at /go.
FROM golang:1.14-alpine

# TODO build from mounted volume after container is started
ADD ./main.go /

# TODO install delve etc here...

# Copy entrypoint.sh to the container
ADD ./entrypoint.sh /
RUN chmod +x /entrypoint.sh

# Run the outyet command by default when the container starts.
ENTRYPOINT /entrypoint.sh
