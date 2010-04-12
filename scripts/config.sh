#!/bin/bash

die() {
  echo "$1" 1>&2
  exit -1
}

export EC2_HOME=$(pwd)/ec2-api-tools-1.3-46266
export JAVA_HOME=$(realpath $(dirname $(realpath $(which java)))/../..)
export PATH=$EC2_HOME/bin:$PATH
export EC2_PRIVATE_KEY=$HOME/.ec2/ec2-private-key.pem
export EC2_CERT=$HOME/.ec2/ec2-cert.pem
export CONTROLLER_IP_ADDRESS_FILE=$HOME/.ec2/controller-ip-address

-d $EC2_HOME || die("ec2-api-tools-1.3-46266 is required in the current directory")
-e $(which java) || die("Must have java on your path")
-e $EC2_PRIVATE_KEY || die("Missing $EC2_PRIVATE_KEY")
-e $EC2_CERT || die("Missing $EC2_CERT")
-e CONTROLLER_IP_ADDRESS_FILE || die("Missing $CONTROLLER_IP_ADDRESS_FILE")

# instance configuration
AMI=ami-dcf615b5
AKI=aki-6eaa4907
ARI=ari-42b95a2b
AMI_DESCRIPTION="EBS Debian Lenny"
AMI_NAME="ebs-debian-lenny-0.1"
AMI_ARCH=i386
ROOT_DEVICE=/dev/sda1

AZ=us-east-1c

KEYPAIR_NAME=$USER
KEYPAIR_FILE=$HOME/.ec2/ec2-keypair.pem
GROUP_NAME=$USER
GROUP_DESCRIPTION="SSH Access Only"
CONTROLLER_IP_ADDRESS=$(cat $CONTROLLER_IP_ADDRESS_FILE)

SPOT_PRICE_DOLLARS=0.4
SPOT_UNTIL_DATETIME=$(date -u +'%Y-%m-%dT%H:%M:%S' -d "now + 1 hour")
STATE_DIR=state
INSTANCE_TYPE=m1.small
START_TIME=$(date -u +'%Y-%m-%dT%H:%M:%S' -d "now - 3 hour")
SNAPSHOT_DESCRIPTION="EBS Debian Lenny"

# state files
SPOT_REQUEST_FILE=$STATE_DIR/spot-request.txt
EBS_SPOT_REQUEST_FILE=$STATE_DIR/ebs-spot-request.txt
EBS_RUN_INSTANCE_FILE=$STATE_DIR/ebs-run-instances.txt
INSTANCES_FILE=$STATE_DIR/instances.txt
EBS_VOLUME_FILE=$STATE_DIR/ebs-volume.txt
EBS_DESCRIBE_VOLUMES_FILE=$STATE_DIR/ebs-describe-volumes.txt
EBS_DESCRIBE_SNAPSHOT_FILE=$STATE_DIR/ebs-describe-snapshot.txt
EBS_ATTACHMENT_FILE=$STATE_DIR/ebs-attachment.txt
EBS_DETACHMENT_FILE=$STATE_DIR/ebs-detachment.txt
EBS_SNAPSHOT_FILE=$STATE_DIR/ebs-snapshot.txt
INSTANCE_ID_FILE=$STATE_DIR/instance.id
EBS_INSTANCE_ID_FILE=$STATE_DIR/instance.id
REGISTER_SNAPSHOT_FILE=$STATE_DIR/register-snapshot.txt

mkdir -p $STATE_DIR
