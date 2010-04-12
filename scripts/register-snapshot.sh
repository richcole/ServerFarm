#!/bin/bash

. scripts/config.sh

set -e

EBS_SNAPSHOT=$(grep SNAPSHOT $EBS_SNAPSHOT_FILE | cut -f 2)

ec2-register \
  --snapshot $EBS_SNAPSHOT \
  --kernel $AKI \
  --ramdisk $ARI \
  --description "$AMI_DESCRIPTION" \
  --name "ebs-debian-lenny-0.1" \
  --architecture $AMI_ARCH \
  --root-device-name $ROOT_DEVICE \
  > $REGISTER_SNAPSHOT_FILE


