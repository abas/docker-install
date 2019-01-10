#!/usr/bin/env bash
set -e
source ./docker-install-helper.sh

function passline () {
    echo "."
    echo "."
    echo "|- $1"
}

echo "---=[ DOCKER INSTALLER ]=---"

if [[ $1 ="-fedora" ]];then
    passline() "adding epel-release repository"
    yum install -y epel-release
    echo "|- done"
fi

passline() "uninstalling old version of docker.."
package-remover() $1

passline() "configure helper tool.."
repo-config() $1

passline() "configure stable repo.."
repo-stable() $1

passline() "docker install.."
docker-install() $1

passline() "enable service"
endis-docker() $1 $2

echo "---=[ DOCKER INSTALLER ]=---"
echo "|    credit by : [Abas]    |"
echo "----------------------------"