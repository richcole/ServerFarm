#!/bin/bash

. scripts/config.sh

set -e

EBS_VOLUME=$(grep VOLUME $EBS_VOLUME_FILE | cut -f 2)

ec2-describe-volumes $EBS_VOLUME > $EBS_DESCRIBE_VOLUMES_FILE
EBS_VOLUME_STATE=$(grep VOLUME $EBS_DESCRIBE_VOLUMES_FILE | grep $EBS_VOLUME | cut -f 6)

while [ "$EBS_VOLUME_STATE" != "available" ] ; do
 echo "Waiting for EBS volume to become available, current state is $EBS_VOLUME_STATE"
 sleep 30
 ec2-describe-volumes $EBS_VOLUME > $EBS_DESCRIBE_VOLUMES_FILE
 EBS_VOLUME_STATE=$(grep VOLUME $EBS_DESCRIBE_VOLUMES_FILE | grep $EBS_VOLUME | cut -f 6)
done
