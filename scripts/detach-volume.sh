#!/bin/bash

. scripts/config.sh

set -e

EBS_VOLUME=$(grep VOLUME $EBS_VOLUME_FILE | cut -f 2)
INSTANCE=$(cat $INSTANCE_ID_FILE)

ec2-detach-volume $EBS_VOLUME > $EBS_DETACHMENT_FILE

