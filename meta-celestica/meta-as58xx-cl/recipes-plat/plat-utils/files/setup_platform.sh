#!/bin/sh
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
# You should have received a copy of the GNU General Public License
# along with this program in a file named COPYING; if not, write to the
# Free Software Foundation, Inc.,
# 51 Franklin Street, Fifth Floor,
# Boston, MA 02110-1301 USA

PATH=/sbin:/bin:/usr/sbin:/usr/bin:/usr/local/bin
. /usr/local/bin/openbmc-utils.sh

board_type=$(board_type)
echo "The board name is $board_type"
echo "Insert kernel modules "
modprobe syscpld
modprobe i2c-mux-pca954x ignore_probe=1
modprobe cpu_error
if [ "$board_type" = "Fishbone48" ]; then
    echo 1 > /sys/devices/virtual/mdio_bus/ftgmac100_mii/led_ctrl
    # modprobe syscpld_fishbone
    modprobe fancpld_fishbone
    echo "Run setup_i2c_fishbone.sh "
    /usr/local/bin/setup_i2c_fishbone.sh
    echo "setup_sensors_fishbone.sh"
    /usr/local/bin/setup_sensors_fishbone.sh
elif [ "$board_type" = "Fishbone32" ]; then
    echo 1 > /sys/devices/virtual/mdio_bus/ftgmac100_mii/led_ctrl
    # modprobe syscpld_fishbone
    modprobe fancpld_fishbone
    echo "Run setup_i2c_fishbone.sh "
    /usr/local/bin/setup_i2c_fishbone.sh
    echo "setup_sensors_fishbone.sh"
    /usr/local/bin/setup_sensors_fishbone.sh
else
    # modprobe syscpld_phalanx
    modprobe fancpld_phalanx
    echo "Run setup_i2c_phalanx.sh "
    /usr/local/bin/setup_i2c_phalanx.sh
    echo "setup_sensors_phalanx.sh"
    /usr/local/bin/setup_sensors_phalanx.sh
fi
echo "Done"

