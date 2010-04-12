#!/bin/bash

. scripts/config.sh

set -e

ec2-request-spot-instances     \
  $AMI                         \
  -g $GROUP_NAME               \
  -k $KEYPAIR_NAME             \
  -p $SPOT_PRICE_DOLLARS       \
  -r 'one-time'                \
  -t $INSTANCE_TYPE            \
  -z $AZ
  --valid-until $SPOT_UNTIL_DATETIME \
  > $SPOT_REQUEST_FILE
