#!/usr/bin/env bash
set -eu # exit on error or undefined variable
bash -c 'set -o pipefail' # return code of first cmd to fail in a pipeline

APP_NAME=${APP_NAME}
APP_MNT="/mnt/${APP_NAME}"

# host.docker.internal might not always resolve, hard code host.ip on startup
HOST_IP=`getent hosts host.docker.internal | awk '{ print $1 }'`
if [[ -z "$HOST_IP" ]]
then
    # host.docker.internal is only available on docker for mac
    HOST_IP=`/sbin/ip route | awk '/default/ { print $3 }'`
fi

echo "Hosts file..............................................................."
echo "" >> /etc/hosts
echo "${HOST_IP}   host.ip" >> /etc/hosts

#echo "Symlinks................................................................."
## Don't run if symlink already exists
#if [[ ! -e /root/app ]]; then
#    # This demonstrates that env vars can be used in the start script
#    ln -s ${APP_MNT} /root/${APP_NAME}
#fi
