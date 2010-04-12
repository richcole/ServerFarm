#!/bin/bash

. scripts/config.sh

EBS_VOLUME=$(grep VOLUME $EBS_VOLUME_FILE | cut -f 2)
INSTANCE=$(cat $INSTANCE_ID_FILE)

ec2-describe-volumes $EBS_VOLUME > $EBS_DESCRIBE_VOLUMES_FILE

EBS_ATTACHMENT_STATE=$(grep ATTACHMENT $EBS_DESCRIBE_VOLUMES_FILE | \
  grep $EBS_VOLUME | grep $INSTANCE | cut -f 5)

while [ "$EBS_ATTACHMENT_STATE" != "attached" ] ; do
 echo "Waiting for EBS volume to become attached, current state is $EBS_ATTACHMENT_STATE"
 sleep 30
 ec2-describe-volumes $EBS_VOLUME > $EBS_DESCRIBE_VOLUMES_FILE
 EBS_ATTACHMENT_STATE=$(grep ATTACHMENT $EBS_DESCRIBE_VOLUMES_FILE | \
  grep $EBS_VOLUME | grep $INSTANCE | cut -f 5)
done

