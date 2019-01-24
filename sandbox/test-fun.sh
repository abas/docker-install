#!/bin/bash
set -e
source ../docker-install-helper.sh

echo "|- testing is_number"
if [[ $(is_number 9000) = "true" ]];then
    echo "true"
else
    echo "false"
fi

echo ""
echo "|- testing docker-compose-checker"

if [[ docker-compose-checker == true ]]; then
    echo "docker-compose exist at"
    which docker-compose
else
    echo "docker-compose doesnt exist"
fi