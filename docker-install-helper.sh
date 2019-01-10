#!/usr/bin/env bash
set -e

# package remover
function package-remover () {
    echo " |- removing package.."
    case $1 in
    "-debian")
        apt-get remove -y docker docker-engine docker.io containerd runc
        repo_updater $1
    ;;
    "-fedora")
        yum remove -y docker \
            docker-client \
            docker-client-latest \
            docker-common \
            docker-latest \
            docker-latest-logrotate \
            docker-logrotate \
            docker-selinux \
            docker-engine-selinux \
            docker-engine
    ;;
    "-ubuntu")
        apt-get remove -y docker docker-engine docker.io containerd runc
        repo_updater $1
    ;;
    *)
        echo " |-- no option on package remover"
    ;;
    esac
    echo " |- removing done!"
}

# setup repository
function repo-config () {
    echo " |- configure repository.."
    case $1 in
    "-debian")
        apt-get install -y \
                apt-transport-https \
                ca-certificates \
                curl \
                gnupg2 \
                software-properties-common
        curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -
        apt-key fingerprint 0EBFCD88
    ;;
    "-fedora")
        yum install -y yum-utils \
            device-mapper-persistent-data \
            lvm2
    ;;
    "-ubuntu")
        apt-get install \
                apt-transport-https \
                ca-certificates \
                curl \
                software-properties-common
        curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
        apt-key fingerprint 0EBFCD88
    ;;
    *) echo " |-- no option repo config"
    esac
    echo " |- configurating done"
}

# repository updater
function repo-updater () {
    echo " |- updating repository"
    case $1 in
    "-debian")
        apt-get update -y
    ;;
    "-fedora")
        yum update -y
    ;;
    "-ubuntu")
        apt-get update -y
    ;;
    *) echo " |-- no option on repo updater"
    esac
    echo " |- updating repositoy done"
}

# setup stable repository
function repo-stable () {
    echo " |- configure stable repository"
    case $1 in
    "-debian")
        add-apt-repository \
            "deb [arch=amd64] https://download.docker.com/linux/debian \
            $(lsb_release -cs) \
            stable"
    ;;
    "-fedora")
        yum-config-manager -y \
            --add-repo \
            https://download.docker.com/linux/centos/docker-ce.repo
    ;;
    "-ubuntu")
        add-apt-repository \
            "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
            $(lsb_release -cs) \
            stable"
    ;;
    *) echo " |-- no option on repo stable"
    esac
    echo " |- configure done"
}

# docker installation
function docker-install () {
    install=" |- installing docker"
    case $1 in
    "-debian")
        repo_updater $1
        apt-get install docker-ce
    ;;
    "-fedora")
        yum install docker-ce -y
    ;;
    "-ubuntu")
        repo_updater $1
        apt-get install docker-ce
    ;;
    *) echo " |-- no option on docker install"
    esac
    echo " |- installing done"
}

# service enable / disable docker service
function endis-docker () {
    # $2 -> enable or disable
    endis_message=" |- $2 docker service"
    if [[ $2 = "disable" ]];then
        endis_command=stop
    elif [[ $2 = "enable" ]];then
        endis_command=start
    else
        endis_command=enable
    fi

    echo "systemctl $2 docker"
    if [[ $endis_command = null ]];then
        exit
    else
        case $1 in
        "-debian")
            echo "systemctl $endis_command docker"
        ;;
        "-fedora")
            echo "systemctl $endis_command docker"
        ;;
        "-ubuntu")
            echo "systemctl $endis_command docker"
        ;;
        *) echo " |-- no option on endis docker"
        esac
        echo " |- $2 successfull"
    fi
}