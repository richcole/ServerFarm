#!/bin/bash

. scripts/config.sh

set -e

INSTANCE=$(cat $INSTANCE_ID_FILE)
INSTANCE_PUBLIC_IP=$(grep INSTANCE $INSTANCES_FILE | grep $INSTANCE | cut -f 4)

chmod 600 $KEYPAIR_FILE
ssh -i $KEYPAIR_FILE root@$INSTANCE_PUBLIC_IP
