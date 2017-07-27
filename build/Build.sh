#!/bin/bash

# Generate fixed host keys if they don't already exist
./generate-ssh-host-keys.sh

# Build the container
docker build -t octopus-kubectl:latest .
