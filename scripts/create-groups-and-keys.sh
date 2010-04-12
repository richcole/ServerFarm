#!/bin/bash

. scripts/config.sh

set -e

ec2-delete-keypair $KEYPAIR_NAME || echo "Keypair not deleted, possibly never existed."
ec2-add-keypair $KEYPAIR_NAME | sed -e 1d > $KEYPAIR_FILE

ec2-delete-group $GROUP_NAME
ec2-add-group $GROUP_NAME -d "$GROUP_DESCRIPTION"
ec2-authorize $GROUP_NAME -P tcp -p 22 -s $CONTROLLER_IP_ADDRESS/32

ec2-describe-spot-price-history -t $INSTANCE_TYPE -s $START_TIME
