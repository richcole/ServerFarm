#!/bin/bash

. scripts/config.sh

set -e

INSTANCE=$(grep INSTANCE $EBS_RUN_INSTANCE_FILE | cut -f 2)
echo $INSTANCE > $EBS_INSTANCE_ID_FILE

ec2-describe-instances > $INSTANCES_FILE
INSTANCE_STATE=$(grep INSTANCE $INSTANCES_FILE | grep $INSTANCE | cut -f 6)
while [ "$INSTANCE_STATE" != "running" ] ; do
  echo "Waiting for instance to enter running state ..."
  sleep 30
  echo "Describing instance $INSTANCE"
  ec2-describe-instances > $INSTANCES_FILE
  INSTANCE_STATE=$(grep INSTANCE $INSTANCES_FILE | grep $INSTANCE | cut -f 6)
done

               