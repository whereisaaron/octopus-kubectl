#!/bin/bash
# Create a Secret with ssh key, authorized public keys, and AWS credentials
#
# Settings can be specified using command line arguments or environment variables
#
# Note that if you update the Secret you do not need to restart the pod,
# the mapped files will be updated automatically
#

# Exit on first error
set -e

#
# Parse options
#

display_usage ()
{
  echo "Usage: $0 [--namespace=<namespace> --authkeys=<authorized_keys> --key=<key> --pubkey=<pubkey> --awscreds=<credentials>] [--help]"
  echo "  Default --namespace is 'default'"
  echo "  Default --authkeys is 'authorized_keys'"
  echo "  Default --pubkey is 'id_rsa.pub'"
  echo "  Default --key is 'id_rsa'"
  echo "  Default --awscreds is 'credentials'"
}

for i in "$@"
do
case $i in
    --namespace=*)
    NAMESPACE="${i#*=}"
    shift # past argument=value
    ;;
    --authkeys=*)
    AUTHORIZED_KEY_FILE="${i#*=}"
    shift # past argument=value
    ;;
    --key)
    PRIVATE_KEY_FILE="${i#*=}"
    shift # past argument=value
    ;;
    --pubkey=*)
    PUBLIC_KEY_FILE="${i#*=}"
    shift # past argument=value
    ;;
    --awscreds=*)
    AWS_CREDENTIALS_FILE="${i#*=}"
    shift # past argument=value
    ;;
    --help)
    display_usage
    exit 0
    ;;
    *)
    # unknown option
    echo "Unknown option $1"
    display_usage
    exit 1
    ;;
esac
done

#
# Defaults and log namespace and files used
#

NAMESPACE=${NAMESPACE:-default}
echo "Using namespace ${NAMESPACE}"

AUTHORIZED_KEYS_FILE=${AUTHORIZED_KEYS_FILE:-authorized_keys}
echo "Using authorized_keys from ${AUTHORIZED_KEYS_FILE}"

PRIVATE_KEY_FILE=${PRIVATE_KEY_FILE:-id_rsa}
echo "Using id_rsa from ${AUTHORIZED_KEYS_FILE}"

PUBLIC_KEY_FILE=${PUBLIC_KEY_FILE:-id_rsa.pub}
echo "Using id_rsa.pub from ${AUTHORIZED_KEYS_FILE}"

AWS_CREDENTIALS_FILE=${AWS_CREDENTIALS_FILE:-credentials}
echo "Using credentials from ${AWS_CREDENTIALS_FILE}"

#
# Create and label ConfigMap
#

SECRET_NAME=octopus-kubectl
kubectl delete secret --ignore-not-found $SECRET_NAME --namespace=$NAMESPACE
kubectl create secret generic $SECRET_NAME \
  --namespace=$NAMESPACE \
  --from-file=authorized_keys=${AUTHORIZED_KEYS_FILE} \
  --from-file=id_rsa=${PRIVATE_KEY_FILE} \
  --from-file=id_rsa.pub=${PUBLIC_KEY_FILE} \
  --from-file=credentials=${AWS_CREDENTIALS_FILE}
kubectl label secret $SECRET_NAME app=octopus-kubectl --namespace=$NAMESPACE
