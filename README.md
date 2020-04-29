# go-docker-debug

Debugging go inside docker with auto reloading.

This lets you develop on your host, 
while building and running your app inside a VM.
Safely collaborate and experiment without breaking your primary machine 

Reloading is initiated by the host. Compilation is done inside docker

This example will use [fswatch](https://github.com/emcrisostomo/fswatch)
for change detection. The best tool for detecting changes might vary by host OS

I like to vendor my dependencies using modules outside GOPATH,
and this example also works like that.
For projects inside GOPATH see the example Dockerfile
[here](https://github.com/mozey/go-docker-debug#deploying-go-servers-with-docker)

## Quick Start

Get the code
    
    git clone https://github.com/mozey/go-docker-debug.git
    
    cd go-docker-debug
    
**Optionally** run the program on your host

    go run -ldflags "-X main.addr=:8118" main.go

...and [confirm it works](http://localhost:8118)
    
[Docker compose](https://docs.docker.com/compose/install) 
comes with Docker Desktop, 
make sure you have it installed first.
Build and run the container    
    
    docker-compose up
    
#### Remote debug from [Goland](https://www.jetbrains.com/go/)

    TODO

#### Remote debug from [VSCode](https://code.visualstudio.com/)

    TODO
    
#### Remote debug from [Vim](https://www.vim.org/)
    
    TODO

#### Instructions for additional IDEs or editors? 

    Send me a pull request pls!
    
## Manually build and run the container

You don't have to use Docker Compose,
follow the instructions below instead

    cd go-docker-debug

Build image

    docker build -t go-dd -f ./Dockerfile --rm ./ 
    
Create container

    docker create --name go-dd -p 8118:8118 go-dd
    
Start container

    docker start go-dd
    
Stop container

    docker stop go-dd
    
Cleanup

    docker rm go-dd && docker image rm go-dd

## Reference

#### [Deploying Go servers with Docker](https://blog.golang.org/docker)

#### [How to debug Golang applications inside Docker containers using Delve](https://mikemadisonweb.github.io/2018/06/14/go-remote-debug/)
