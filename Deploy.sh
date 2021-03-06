#!/bin/bash

# stop on first error
set -e

#
# Set environment variables to customise the deployment
#   DOCKER_IMAGE
#   AUTHORIZED_KEYS_FILE
#   SSH_CONFIG_FILE
#   PUBLIC_KEY_FILE
#   PRIVATE_KEY_FILE
#   AWS_CREDENTIALS_FILE
#   NAMESPACE
#   SERVICEACCOUNT
#   NODEPORT 
#   HELM_HOST
#

# Deploy from repo, combine with config
pushd deploy
./create-secret.sh
./Deploy.sh
popd
