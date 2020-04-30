# go-docker-debug

Debugging go inside docker with auto reloading.

This lets you develop on your host, 
while building and running your app inside a <s>VM</s> container.
Safely collaborate and experiment without breaking your primary machine 

Reloading is initiated by the host. Compilation is done inside the container

[fswatch](https://github.com/emcrisostomo/fswatch)
is used for change detection (of source files). 
The best tool for detecting changes might vary by host OS

I like to use modules outside GOPATH and vendor dependencies,
this example also works like that.
For projects inside GOPATH see the example Dockerfile
[here](https://blog.golang.org/docker)

The Docker build is multi stage using 
[phusion/baseimage](https://github.com/phusion/baseimage-docker).
I use Ubuntu for production servers and it makes sense to have the same on dev.
This approach is also useful for projects that rely on more than just golang,
and when I can't be bothered to create a dev container for every single dep

The multi stage build first creates a base image with the OS and dependencies,
see [base/Dockerfile](https://github.com/mozey/go-docker-debug/blob/master/docker/base/Dockerfile).

The [second stage](https://github.com/mozey/go-docker-debug/blob/master/docker/app/Dockerfile) 
builds on top of the base image and it lets you
- quickly re-purpose a previously built base image
- write configuration files with [app/setup.sh](https://github.com/mozey/go-docker-debug/blob/master/docker/app/setup.sh) 
- run a [script during container startup](https://github.com/phusion/baseimage-docker#running-scripts-during-container-startup),
see [app/start.sh](https://github.com/mozey/go-docker-debug/blob/master/docker/app/start.sh)
- enables SSHing into the container 
by appending your public key to `~/.ssh/authorized_keys`

In summary, after setting up the container, 
you don't need any docker specific knowledge.
Use the same remote debugging workflow as with any other server    

## Quick Start

Get the code
    
    git clone https://github.com/mozey/go-docker-debug.git
    
    cd go-docker-debug
    
**Optionally** run the program on your host

    go run -ldflags "-X main.addr=:8118" main.go

...and [confirm it works](http://localhost:8118)
    
The container will include your public key for SSH access.
Skip this step if you don't care about that

    ssh-keygen -t rsa
        
    cp ~/.ssh/id_rsa.pub ./scripts/docker/app/id_rsa.pub
    
Manually build and run the container. 
Have a look at the step by step commands in the scripts

Build the image (and optionally the base image) 

    ./scripts/docker/image.sh
    
Build the container
    
    APP_DIR=$(pwd) PORT=8118 SSH=8119 ./scripts/docker/container.sh
    
...(re)start the container
    
    ./scripts/app/restart.sh
    
...ssh into the container

    ssh -p 8119 root@localhost
    
    # Remove key verification after rebuild
    sed -i.bak '/\[localhost\]:8119/d' ~/.ssh/known_hosts
    
...attached to tmux session with running app

    ./scripts/app/tmux.sh
    
...reload app
    
    ./scripts/app/reload.sh
    
Auto reload

    make app    
        
**Alternatively**, 
use [Docker compose](https://docs.docker.com/compose/install).
It comes with Docker Desktop, make sure you have that installed first.
Build and run the container 
    
    # TODO
    docker-compose up

...or stop it

    docker-compose down
    
## IDEs and Editors

Instructions for additional IDEs or editors? 
Send me a pull request pls!
    
#### Remote debug from [Goland](https://www.jetbrains.com/go/)

Make sure the container is running

    docker ps

Then setup your IDE like this

    TODO

#### Remote debug from [VSCode](https://code.visualstudio.com/)

    TODO
    
#### Remote debug from [Vim](https://www.vim.org/)
    
    TODO

## Reference

[How to debug Golang applications inside Docker containers using Delve](https://mikemadisonweb.github.io/2018/06/14/go-remote-debug/)

[How To Install Go on Ubuntu 18.04](https://www.digitalocean.com/community/tutorials/how-to-install-go-on-ubuntu-18-04)

[Attaching to a tmux session via SSH](https://superuser.com/a/912400/537059)