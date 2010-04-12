#!/bin/bash
# Run this script on the instance to be bundled
# tested with Canonical Ubuntu 9.10 base ami

EBS_DEVICE=/dev/sdh
IMAGE_DIR=/mnt/tmp
EBS_MOUNT_POINT=/mnt/ebs

mkdir -p $EBS_MOUNT_POINT
echo "y" | mkfs.ext3 ${EBS_DEVICE}
mount  ${EBS_DEVICE} $EBS_MOUNT_POINT

# make a local working copy
mkdir /mnt/tmp
rsync --stats -av --exclude /root/.bash_history --exclude /home/*/.bash_history --exclude /etc/ssh/ssh_host_* --exclude /etc/ssh/moduli --exclude /etc/udev/rules.d/*persistent-net.rules --exclude /var/lib/ec2/* --exclude=/mnt/* --exclude=/proc/* --exclude=/tmp/* / $IMAGE_DIR

# clear out log files
echo "Emptying log files"
cd $IMAGE_DIR/var/log
for i in `ls ./**/*`; do
  echo $i && echo -n> $i
done

cd $IMAGE_DIR
tar -cSf - -C ./ . | tar xvf - -C $EBS_MOUNT_POINT

umount $EBS_MOUNT_POINT
