#!/bin/bash
# Create a Secret with ssh public keys and AWS credentials
#
# Note that if you update the Secret you do not need to restart the pod,
# the mapped authorized_keys file will be updated automatically
#
# You can also pass a file name: create-config.sh /path/to/my_authorized_keys_file /path/to/my_credentials_file
#

# Exit on first error
set -e

# Optionally you can set a custom name space
NAMESPACE=${NAMESPACE:-default}
echo "Using namespace ${NAMESPACE}"

# Use authorized_keys in this folder unless a file is specified
AUTHORIZED_KEYS_FILE=${AUTHORIZED_KEYS_FILE:-authorized_keys}
if [ "$1" != "" ]; then
  AUTHORIZED_KEYS_FILE=$1
fi
echo "Using authorized_keys from ${AUTHORIZED_KEYS_FILE}"

# Use credentials in this folder unless a file is specified
CREDENTIALS_FILE=${CREDENTIALS_FILE:-credentials}
if [ "$2" != "" ]; then
  CREDENTIALS_FILE=$2
fi
echo "Using credentials from ${CREDENTIALS_FILE}"

# Create and label ConfigMap
SECRET_NAME=octopus-kubectl
kubectl delete secret --ignore-not-found $SECRET_NAME --namespace=$NAMESPACE
kubectl create secret generic $SECRET_NAME \
  --from-file=authorized_keys=${AUTHORIZED_KEYS_FILE} \
  --from-file=credentials=${CREDENTIALS_FILE} \
  --namespace=$NAMESPACE
kubectl label secret $SECRET_NAME app=octopus-kubectl --namespace=$NAMESPACE
