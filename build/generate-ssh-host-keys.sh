#!/bin/bash
#
# We want the host keys to be consistent for this application
# and avoid new host keys being generated on each container restart
# which trigger erroneous warnings for the client
#

mkdir -p host-keys

if [[ ! -f host-keys/ssh_host_ed25519_key ]]; then
  ssh-keygen -t ed25519 -f host-keys/ssh_host_ed25519_key < /dev/null
else
  echo "host-keys/ssh_host_ed25519_key exists, not overwriting"
fi

if [[ ! -f host-keys/ssh_host_rsa_key ]]; then
  ssh-keygen -t rsa -b 4096 -f host-keys/ssh_host_rsa_key < /dev/null
else
  echo "host-keys/ssh_host_ed25519_key exists, not overwriting"
fi
