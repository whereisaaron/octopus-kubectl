#!/bin/bash

#
# Copy Kubernetes API environment variables to root profile,
# so the environment variables are available to kubectl
# when Octopus uses ssh
#
# If the container is no running in Kubernetes or you want
# to deploy to a remote Kubernetes cluster then you should
# mount a /root/.kube/config file to enable access
#

env | grep KUBERNETES_ >> /root/.profile

#
# Start sshd unless an alternative command supplied
#

if [ $# -gt 0 ]
then
  exec $*
else
  # container build creates /var/run/sshd chmod 0755
  exec /usr/sbin/sshd -D -q
fi
