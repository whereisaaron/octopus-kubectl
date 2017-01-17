#!/bin/bash

# Optionally you can set a custom name space
export NAMESPACE=${NAMESPACE:-default}

# Optionally you can set a custom name space
export SERVICEACCOUNT=${SERVICEACCOUNT:-default}

# Optionally you can set the fixed NodePort to use
export NODEPORT=${NODEPORT:-31800}

envsubst < octopus-kubectl-template.yaml | kubectl apply -f -
