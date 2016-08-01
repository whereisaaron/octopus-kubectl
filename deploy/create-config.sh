#!/bin/bash
set -e

CONFIGMAP_NAME=octopus-kubectl

AUTHORIZED_KEYS_FILE=authorized_keys
if [ "$1" != "" ]; then
  AUTHORIZED_KEYS_FILE=$1
fi
echo Using authorized_keys from ${AUTHORIZED_KEYS_FILE}

kubectl delete configmap --ignore-not-found $CONFIGMAP_NAME
kubectl create configmap $CONFIGMAP_NAME --from-file=authorized-keys=${AUTHORIZED_KEYS_FILE}
kubectl label configmap $CONFIGMAP_NAME app=octopus-kubectl
