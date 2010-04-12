#!/bin/bash

. scripts/config.sh

set -e

EBS_SNAPSHOT=$(grep SNAPSHOT $EBS_SNAPSHOT_FILE | cut -f 2)

ec2-describe-snapshots $EBS_SNAPSHOT > $EBS_DESCRIBE_SNAPSHOT_FILE
EBS_SNAPSHOT_STATE=$(grep SNAPSHOT $EBS_DESCRIBE_SNAPSHOT_FILE | grep $EBS_SNAPSHOT \
  | cut -f 4)

while [ "$EBS_SNAPSHOT_STATE" != "completed" ] ; do
 echo "Waiting for EBS snapshot to become available, current state is $EBS_SNAPSHOT_STATE"
 sleep 30
 ec2-describe-snapshots $EBS_SNAPSHOT > $EBS_DESCRIBE_SNAPSHOTS_FILE
 EBS_SNAPSHOT_STATE=$(grep SNAPSHOT $EBS_DESCRIBE_SNAPSHOT_FILE | grep $EBS_SNAPSHOT \
  | cut -f 4)
done
