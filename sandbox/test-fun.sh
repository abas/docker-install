#!/bin/bash
set -e
source /Users/vander/.abas/docker-install/docker-install-helper.sh

if [[ $(is_number 9000) = "true" ]];then
    echo "true"
else
    echo "false"
fi