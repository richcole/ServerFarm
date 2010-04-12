#!/bin/bash

. scripts/config.sh

set -e

SPOT_REQUEST=$(grep SPOTINSTANCEREQUEST $SPOT_REQUEST_FILE | cut -f 2)

if [ -e $INSTANCES_FILE ] ; then
  INSTANCE=$(grep INSTANCE $INSTANCES_FILE | grep $SPOT_REQUEST | cut -f 2)
else
  INSTANCE=""
fi

while [ -z "$INSTANCE" ] ; do
  echo "Describing instances"
  ec2-describe-instances > $INSTANCES_FILE
  INSTANCE=$(grep INSTANCE $INSTANCES_FILE | grep $SPOT_REQUEST | cut -f 2)
  if [ -z "$INSTANCE" ] ; then 
    echo "Waiting for instance ..."
    sleep 30
  fi 
done

echo $INSTANCE > $INSTANCE_ID_FILE

INSTANCE_STATE=$(grep INSTANCE $INSTANCES_FILE | grep $INSTANCE | cut -f 6)
while [ "$INSTANCE_STATE" != "running" ] ; do
  echo "Waiting for instance to enter running state ..."
  sleep 30
  echo "Describing instance $INSTANCE"
  ec2-describe-instances > $INSTANCES_FILE
  INSTANCE_STATE=$(grep INSTANCE $INSTANCES_FILE | grep $INSTANCE | cut -f 6)
done

               