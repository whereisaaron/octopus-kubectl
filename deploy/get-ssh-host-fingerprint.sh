#!/bin/bash
#
# Octopus requires having the up to date host key in MD5 form
# This script extracts the current host key from the running container
#

: ${1?Must supply ssh domain name}
: ${2?Must supply ssh port number}

tempfile=$(mktemp)
ssh-keyscan -p "${2}" "${1}" 2>/dev/null > $tempfile
ssh-keygen -lf $tempfile | grep "RSA"
rm -f $tempfile
