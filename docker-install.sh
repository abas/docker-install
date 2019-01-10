#!/usr/bin/env bash
set -e
source ./docker-install-helper.sh

echo $1

function passline () {
    echo "."
    echo "."
    echo $1
}

# echo "---=[ DOCKER INSTALLER ]=---"

if [[ -z $1 ]];then
    echo ""
    echo "=-"
    echo "./docker-install.sh [-option-os]"
    echo "=-"
    echo ""
else
    if [[ $2 = "--default" ]];then
        if [[ $1 = "-fedora" ]];then
            passline "adding epel-release repository"
            yum install -y epel-release
            echo "|- done"
        fi

        passline "uninstalling old version of docker.."
        package-remover $1

        passline "configure helper tool.."
        repo-config $1

        passline "configure stable repo.."
        repo-stable $1

        passline "docker install.."
        docker-install $1

        passline "enable service"
        endis-docker $1 $2
    else 
        if [[ $2 = "--add" ]];then
            case $3 in
            "portainer")
                export_port=$4
                docker volume create portainer_data
                if [[ -z $4 ]];then
                    docker run -d \
                            --name portainer \
                            -p 9000:9000 \
                            -v /var/run/docker.sock:/var/run/docker.sock \
                            -v portainer_data:/data \
                            portainer/portainer
                else
                    docker run -d \
                            --name portainer \
                            -p $export_port:9000 \
                            -v /var/run/docker.sock:/var/run/docker.sock \
                            -v portainer_data:/data \
                            portainer/portainer
                fi
                docker ps -a | grep portainer
            ;;
            *) echo "--add option : [portainer,] - request for other"
            esac
        else
            echo "./docker-install.sh [-option-os] --add [-option-add]"
        fi
    fi
fi

# echo "---=[ DONE ]=---"