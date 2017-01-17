#!/bin/bash

# stop on first error
set -e

#
# Set environment variables to customise the deployment
#   AUTHORIZED_KEYS_FILE
#   NAMESPACE
#   SERVICEACCOUNT
#   NODEPORT 
#

# Deploy from repo, combine with config
pushd deploy
./create-config.sh
./Deploy.sh
popd
