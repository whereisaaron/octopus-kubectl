#!/bin/bash
# Create a configMap with ssh public keys
#
# Note that if you update the configMap you do not need to restart the pod,
# the mapped authorized_keys file will be updated automatically
#
# You can also pass a file name: create-config.sh /path/to/my_authorized_keys_file
#

# Exit on first error
set -e

CONFIGMAP_NAME=octopus-kubectl

# Used authorized_keys in this folder unless a file is specified
AUTHORIZED_KEYS_FILE=authorized_keys
if [ "$1" != "" ]; then
  AUTHORIZED_KEYS_FILE=$1
fi
echo Using authorized_keys from ${AUTHORIZED_KEYS_FILE}

kubectl delete configmap --ignore-not-found $CONFIGMAP_NAME
kubectl create configmap $CONFIGMAP_NAME --from-file=authorized-keys=${AUTHORIZED_KEYS_FILE}
kubectl label configmap $CONFIGMAP_NAME app=octopus-kubectl
