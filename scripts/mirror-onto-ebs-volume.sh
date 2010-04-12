#!/bin/bash

. scripts/config.sh

set -e

INSTANCE=$(cat $INSTANCE_ID_FILE)
INSTANCE_PUBLIC_IP=$(grep INSTANCE $INSTANCES_FILE | grep $INSTANCE | cut -f 4)

scp -i $KEYPAIR_FILE scripts/mirror.sh root@$INSTANCE_PUBLIC_IP:/tmp/mirror.sh
ssh -i $KEYPAIR_FILE root@$INSTANCE_PUBLIC_IP bash /tmp/mirror.sh
