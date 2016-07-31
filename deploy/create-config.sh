#!/bin/bash
set -e
CONFIGMAP_NAME=octopus-kubectl
kubectl delete configmap --ignore-not-found $CONFIGMAP_NAME
kubectl create configmap $CONFIGMAP_NAME --from-file=authorized-keys=authorized_keys
kubectl label configmap $CONFIGMAP_NAME app=octopus-kubectl
