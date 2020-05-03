#!/usr/bin/env bash
set -eu # exit on error or undefined variable
bash -c 'set -o pipefail' # return code of first cmd to fail in a pipeline

APP_PATH="/mnt/go-docker-debug"

# host.docker.internal might not always resolve, hard code host.ip on startup
APP_HOST_IP=`getent hosts host.docker.internal | awk '{ print $1 }'`
if [[ -z "$APP_HOST_IP" ]]
then
    # host.docker.internal is only available on docker for mac
    APP_HOST_IP=`/sbin/ip route | awk '/default/ { print $3 }'`
fi

echo "Hosts file..............................................................."
echo "" >> /etc/hosts
echo "${APP_HOST_IP}   host.ip" >> /etc/hosts

#echo "Symlinks................................................................."
## Don't run if symlink already exists
#if [[ ! -e /root/app ]]; then
#    ln -s /mnt/go-docker-debug /root/go-docker-debug
#fi
