#!/bin/bash

. scripts/config.sh

EBS_VOLUME=$(grep VOLUME $EBS_VOLUME_FILE | cut -f 2)

ec2-create-snapshot $EBS_VOLUME --description "$SNAPSHOT_DESCRIPTION" \
  > $EBS_SNAPSHOT_FILE
