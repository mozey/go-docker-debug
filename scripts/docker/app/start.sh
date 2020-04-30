#!/usr/bin/env bash

# Set (e)xit on error
# Set no(u)nset to exit on undefined variable
set -eu
# If any command in a pipeline fails, that return code will be used as the
# return code of the whole pipeline.
bash -c 'set -o pipefail'

APP_PATH="/mnt/app"

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

echo "Symlinks................................................................."
# Don't run if symlink already exists
if [[ ! -e /root/app ]]; then
    ln -s /mnt/app /root/app
fi
