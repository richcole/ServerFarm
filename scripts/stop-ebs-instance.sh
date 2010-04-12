#!/bin/bash

. scripts/config.sh

set -e

INSTANCE=$(cat $EBS_INSTANCE_ID_FILE)

ec2-stop-instances $INSTANCE

