#!/bin/bash
#  Licensed under the Apache License, Version 2.0 (the "License"); you may
#  not use this file except in compliance with the License. You may obtain
#  a copy of the License at
#
#       http://www.apache.org/licenses/LICENSE-2.0
#
#  Unless required by applicable law or agreed to in writing, software
#  distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
#  WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
#  License for the specific language governing permissions and limitations
#  under the License.

exec &> /tmp/install_cf_release.log

function include(){
    curr_dir=$(cd $(dirname "$0") && pwd)
    inc_file_path=$curr_dir/$1
    if [ -f "$inc_file_path" ]; then
        . $inc_file_path
    else
        echo -e "$inc_file_path not found!"
        exit 1
    fi
}
include "common.sh"
. ~/.profile
set_proxy "$1"

if [ ! -z "$1" ]; then
    echo "export http_proxy=$1" >> /etc/profile
    echo "export HTTP_PROXY=$1" >> /etc/profile
    echo "export HTTPS_PROXY=$1" >> /etc/profile
fi

if [ ! -e /tmp/wagrant-reboot ] ; then
  cd /root/cf_nise_installer
  retry 3 ./scripts/install_cf_release.sh
  touch /tmp/wagrant-reboot
  reboot
fi

