#!/bin/bash

# Optionally you can set a custom name space
export NAMESPACE=${NAMESPACE:-default}

kubectl get svc,pod,cm --selector app=octopus-kubectl --namespace=${NAMESPACE}
