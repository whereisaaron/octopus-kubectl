#!/bin/bash

# stop on first error
set -e

# deploy from repo, combine with config
pushd deploy
./create-config.sh
./deploy.sh
popd
