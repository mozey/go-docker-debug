#!/usr/bin/env bash

# Set (e)xit on error
# Set no(u)nset to exit on undefined variable
set -eu
# If any command in a pipeline fails, that return code will be used as the
# return code of the whole pipeline.
bash -c 'set -o pipefail'

HOME="/root"
APP_HOST_NAME="go-docker-debug"
APP_BASH_PROFILE="${HOME}/.profile"
APP_HOST_IP="host.ip" # /etc/hosts is configured in start.sh
APP_PATH="/mnt/app"

echo "Profile.................................................................."
echo "" >> ${APP_BASH_PROFILE}
echo "# App" >> ${APP_BASH_PROFILE}
echo "export APP_PATH=${APP_PATH}" >> ${APP_BASH_PROFILE}
echo "export APP_HOST_NAME=${APP_HOST_NAME}" >> ${APP_BASH_PROFILE}
echo "export GOPATH=/root/go" >> ${APP_BASH_PROFILE}
echo 'export PATH=$PATH:/usr/local/go/bin:$GOPATH/bin' >> ${APP_BASH_PROFILE}
echo "" >> ${APP_BASH_PROFILE}
echo "# Prompt" >> ${APP_BASH_PROFILE}
echo 'PS1="\n<\[\033[0;32m\]${APP_HOST_NAME}\[\033[0m\]:\[\033[0;37m\]\u\[\033[0m\]> \j [\$(date +%d-%m\" \"%H:%M)] \w \n> "' >> ${APP_BASH_PROFILE}
echo "" >> ${APP_BASH_PROFILE}

echo "Vim......................................................................"
echo '
" Tab settings
set ts=4
set shiftwidth=4
set expandtab
" Search settings
set hlsearch " :noh to turn of highlight
set incsearch
" Do not wrap long lines
set nowrap
" Show line numbers
set nu
' > ${HOME}/.vimrc

