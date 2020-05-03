#!/usr/bin/env bash
set -eu # exit on error or undefined variable
bash -c 'set -o pipefail' # return code of first cmd to fail in a pipeline

# This script sets the dev env.
# All env vars used by this module must be set in here.

export APP_DIR=$(pwd)

export APP_DELVE="8120"
export APP_NAME="go-docker-debug"
export APP_PORT="8118"
export APP_SSH="8119"

printenv | grep APP_

# After setting the env,
# execute the arguments passed into this script
exec "$@"
