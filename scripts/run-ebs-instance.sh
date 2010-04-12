#!/bin/bash

. scripts/config.sh

set -e

AMI=$(grep IMAGE $REGISTER_SNAPSHOT_FILE | cut -f 2)

ec2-run-instances              \
  $AMI                         \
  -g $GROUP_NAME               \
  -k $KEYPAIR_NAME             \
  -t $INSTANCE_TYPE            \
  -z $AZ                       \
  > $EBS_RUN_INSTANCE_FILE
