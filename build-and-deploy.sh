#!/bin/bash

# stop on firets error
set -e

# build to repo
pushd build
./build.sh
./tag-and-push.sh
popd

# deploy from repo, combine with config
pushd deploy
./create-config.sh
./deploy.sh
popd
