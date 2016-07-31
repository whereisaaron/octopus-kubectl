#!/bin/bash

#
# Start sshd
#

service ssh start

#
# Wait forever, unless arguments, in which case exec them
#

if [ $# -gt 0 ]
then
  exec $*
else
  # Never exit so container keeps running
  echo "Waiting forever..."
  while true; do sleep 3600; done
fi
