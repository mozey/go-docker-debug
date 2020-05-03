#!/usr/bin/env bash
set -eu # exit on error or undefined variable
bash -c 'set -o pipefail' # return code of first cmd to fail in a pipeline

HOME="/root"
BASH_PROFILE="${HOME}/.profile"

# Set a name here if the container is running multiple apps...
APP_NAME=${APP_NAME}

echo "Profile.................................................................."
echo "" >> ${BASH_PROFILE}
echo "# App" >> ${BASH_PROFILE}
echo "export GOPATH=/root/go" >> ${BASH_PROFILE}
echo 'export PATH=$PATH:/usr/local/go/bin:$GOPATH/bin' >> ${BASH_PROFILE}
echo "" >> ${BASH_PROFILE}
echo "# Prompt" >> ${BASH_PROFILE}
echo 'PS1="\n<\[\033[0;32m\]${APP_NAME}\[\033[0m\]:\[\033[0;37m\]\u\[\033[0m\]> \j [\$(date +%d-%m\" \"%H:%M)] \w \n> "' >> ${BASH_PROFILE}
echo "" >> ${BASH_PROFILE}

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

