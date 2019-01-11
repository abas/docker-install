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
    if [[ $2 = "--default" ]] && [[ -z $3 ]];then
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
        endis-docker $1 enable
    else
        if [[ $2 = "--add" ]];then
            case $3 in
            "portainer")
                expose_port=$5
                container_name=$4
                docker volume create portainer_data

                function crete_container_portainer () {
                    # $1 container_name
                    # $2 expose_port
                    docker run -d \
                            --name $1 \
                            -p $2:9000 \
                            -v /var/run/docker.sock:/var/run/docker.sock \
                            -v portainer_data:/data \
                            portainer/portainer
                }

                if [[ -z $5 ]] && [[ -z $4 ]];then
                    crete_container_portainer portainer 9000
                else
                    if [[ -z $4 ]];then
                        crete_container_portainer $container_name 9000
                    elif [[ -z $5 ]];then
                        crete_container_portainer portainer $expose_port
                    else
                        crete_container_portainer $container_name $expose_port
                    fi
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