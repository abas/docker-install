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
        endis-docker start
    else
        if [[ $2 = "--add" ]];then
            case $3 in
            "portainer")
                if [[ $(docker volume ls | grep portainer_data > /dev/null ;echo $?) -gt 0 ]];then
                    docker volume create portainer_data
                else
                    echo "portainer volume is Existed"
                fi

                function create_container_portainer () {
                    # $1 container_name
                    # $2 expose_port
                    docker run -d \
                            --name $1 \
                            -p $2:9000 \
                            -v /var/run/docker.sock:/var/run/docker.sock \
                            -v portainer_data:/data \
                            portainer/portainer
                }

                # command -bas_os --add portainer "portainer-d" 12345
                if [[ -z $5 ]];then
                    if [[ $(is_number $4) = "false" ]];then
                        # command -base_os --add portainer 12345 <- port
                        create_container_portainer "portainer" $4
                    else
                        # command -base_od --add portainer "portainer-d" <- containe_name
                        create_container_portainer $4 9000
                    fi
                elif [[ -z $4 ]];then 
                    create_container_portainer "portainer" 9000
                else
                    # $4 - container_name
                    # $5 - expose_port
                    create_container_portainer $4 $5
                fi
                docker ps -a | grep portainer
            ;;
            "docker-compose")
                if ! [[ -z $4 ]]; then
                    echo "|- ./docker-install.sh [base_os] --add docker-compose"
                    echo "|-- there is no optional here :> sorry"
                else
                    if [[ ishas-docker-compose == true ]]; then
                        echo "|-- docker-compose exist at : $(which docker-compose) :>"
                    else
                        echo "|- installing docker-compose.."
                        docker-compose-install
                    fi
                fi
            ;;
            *) 
                echo "--add option :"
                echo "|- portainer : dashboard container portainer installer"
                echo "|- docker-compose : docker-compose installer"
                echo "|"
                echo "|-- pull request for other :>"
            esac
        else
            echo "./docker-install.sh [-option-os] --add [-option-add]"
        fi
    fi
fi

# echo "---=[ DONE ]=---"