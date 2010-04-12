#!/bin/bash

. scripts/config.sh

ec2-create-volume --size 20 -z $AZ > $EBS_VOLUME_FILE

