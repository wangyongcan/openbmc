#!/bin/sh
#
# Copyright 2018-present Facebook. All Rights Reserved.
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
#

. /usr/local/bin/openbmc-utils.sh

TTY=/dev/ttyS1

mTerm_server_running() {
  pid=$(ps | grep -v grep | grep '/usr/local/bin/mTerm_server' -m 1 |
      awk '{print $1}')
  if [ $pid ] ; then
    return 0
  fi
  return 1
}

start_sol_session() {
  echo "You are in SOL session."
  echo "Use ctrl-x to quit."
  echo "-----------------------"
  echo

  /usr/bin/microcom -s 9600 $TTY

  echo
  echo
  echo "-----------------------"
  echo "Exit from SOL session."
}

# if mTerm server is running use mTerm_client to connect to userver
# otherwise fallback to the old method

if mTerm_server_running; then
  sol_ctrl BMC
  exec /usr/local/bin/mTerm_client console
else
  start_sol_session
fi
