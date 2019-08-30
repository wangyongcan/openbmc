#!/bin/bash
#
# Copyright 2018-present Celestica. All Rights Reserved.
#
# This program file is free software; you can redistribute it and/or modify it
# under the terms of the GNU General Public License as published by the
# Free Software Foundation; version 2 of the License.
#
# This program is distributed in the hope that it will be useful, but WITHOUT
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
# FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
# for more details.
#
. /usr/local/bin/openbmc-utils.sh

PATH=/sbin:/bin:/usr/sbin:/usr/bin:/usr/local/bin

DEV="/dev/mmcblk0"
MOUNT_POINT="/mnt/emmc"
info=`blkid $DEV`

if [ ! "$info" ]; then
    echo -n "Format EMMC disk ......"
    logger "Format EMMC disk ......"
	mkfs.ext2 $DEV
	echo " Done"
	echo -n "Mouting EMMC ......"
	if [ ! -d "$MOUNT_POINT" ]; then
		mkdir $MOUNT_POINT
	fi
	mount $DEV $MOUNT_POINT
	mkdir $MOUNT_POINT/sol_log
	echo " Done"
else
	echo -n "Mouting EMMC ......"
	if [ ! -d "$MOUNT_POINT" ]; then
		mkdir $MOUNT_POINT
	fi
	e2fsck -a $DEV
	mount $DEV $MOUNT_POINT
	if [ ! -d "$MOUNT_POINT/sol_log" ]; then
		mkdir $MOUNT_POINT/sol_log
	fi
    echo " Done"
fi

