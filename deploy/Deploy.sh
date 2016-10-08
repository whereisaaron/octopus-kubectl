#!/bin/bash

# Optionally you can set a custom name space
if [ -z "$NAMESPACE" ]; then
  export NAMESPACE=default
else
  export NAMESPACE
fi

# Optionally you can set a custom name space
if [ -z "$SERVICEACCOUNT" ]; then
  export SERVICEACCOUNT=default
else
  export SERVICEACCOUNT  
fi

# Optionally you can set the fixed NodePort to use
if [ -z "$NODEPORT" ]; then
  export NODEPORT=31800
else
  export NODEPORT
fi

envsubst < octopus-kubectl-template.yaml | kubectl apply -f -
