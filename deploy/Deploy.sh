#!/bin/bash

# Optionally you can set a custom name space
export NAMESPACE=${NAMESPACE:-default}

# Optionally you can set a custom name space
export SERVICEACCOUNT=${SERVICEACCOUNT:-default}

# Optionally you can set the fixed NodePort to use
export NODEPORT=${NODEPORT:-31800}

# Optionally you can set the helm tiller service domain name to use
export HELM_HOST=${HELM_HOST:-tiller-deploy.kube-system.svc.cluster.local:44134}

# Optionally specifiy your own image repository
export DOCKER_IMAGE=${DOCKER_IMAGE:-whereisaaron/octopus-kubectl:latest}

envsubst < octopus-kubectl-template.yaml | kubectl apply -f -
