#!/usr/bin/make -f

# This makefile is not real. Rather it just lists the commands and the
# order they are run.
#
# What these scripts to is convert the Debian/Lenny AMI from Alestic to a boot
# from EBS AMI. This involes allocating an EBS volume, taking a snapshot, 
# registering it.
#
# After running these scripts probably you'll want to use the AWS Management
# Console to terminate and stop the running instances.

create-groups-and-keys:
	scripts/create-groups-and-keys.sh

run-instance:
	scripts/run-instance.sh

wait-for-instance:
	scripts/wait-for-instance.sh

create-ebs-volume:
	scripts/create-ebs-volume.sh

wait-for-ebs-volume:
	scripts/wait-for-ebs-volume.sh

state/ebs-attachment.txt:
	scripts/attach-volume.sh

wait-for-ebs-volume-to-attach:
	scripts/wait-for-ebs-volume-to-attach.sh

mirror-onto-ebs-volume:
	scripts/mirror-onto-ebs-volume.sh

detach-volume:
	scripts/detach-volume.sh

wait-for-web-volume-to-detach:
	scripts/wait-for-ebs-volume-to-detach.sh

create-snapshot:
	scripts/create-snapshot.sh

wait-for-snapshot:
	scripts/wait-for-snapshot.sh

register-snapshot:
	scripts/register-snapshot.sh

run-ebs-instance:
	scripts/run-ebs-instance.sh

wait-for-ebs-instance:
	scripts/wait-for-ebs-instance.sh

ssh-to-ebs-instance:
	scripts/ssh-to-ebs-instance.sh


