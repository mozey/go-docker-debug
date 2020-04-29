# go-docker-debug

Debugging go inside docker with auto reloading.

Reloading is initiated by the host. Compilation is done inside docker

This example will use [fswatch](https://github.com/emcrisostomo/fswatch)
for change detection. The best tool for detecting changes might vary by host OS

## Quick Start

Get the code
    
    git clone https://github.com/mozey/go-docker-debug.git
    
    cd go-docker-debug
    
**Optionally** run the program on your host

    go run -ldflags "-X main.addr=:8118" main.go

...and [confirm it works](http://localhost:8118)
    
Docker compose comes with Docker Desktop, 
make sure you have it [installed](https://docs.docker.com/compose/install).
Build and run the container    
    
    docker-compose up
    
Remote debug from [Goland](https://www.jetbrains.com/go/)

    TODO

Remote debug from [VSCode](https://code.visualstudio.com/)

    TODO
    
Remote debug from [Vim](https://www.vim.org/)
    
    TODO

Instructions for additional IDEs or editors? Send me a pull request!
