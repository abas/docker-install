#!/usr/bin/env bash
set -e

# package remover
function package-remover () {
    echo " |- removing package.."
    case $1 in
    "-debian")
        apt-get remove -y docker docker-engine docker.io containerd runc
        repo-updater $1
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
        repo-updater $1
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
        apt-get install -y \
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
        add-apt-repository -y \
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
        add-apt-repository -y \
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
        repo-updater $1
        apt-get install -y docker-ce
    ;;
    "-fedora")
        yum install docker-ce -y
    ;;
    "-ubuntu")
        repo-updater $1
        apt-get install -y docker-ce
    ;;
    *) echo " |-- no option on docker install"
    esac
    echo " |- installing done"
}

# service enable / disable docker service
function endis-docker () {
    function start-enable-dockerd () {
        if [[ systemctl-check == "installed" ]]; then
            echo " |- enable docker service.." \
            && systemctl enable docker \
            && echo " |-- enable successfull!" \

            echo "|- starting docker service.." \
            && systemctl start docker \
            && echo " |-- starting successfull." \
            || echo " |-- starting failed!"
        else
            echo " |- starting docker service.." \
            && service docker start \
            && echo " |-- staring successfull!" \
            || echo " |-- starting failed!"
        fi
    }

    if [[ -z $1 ]]; then
        echo " |-- error no option parameter on enable disable docker function.."
    else
        if [[ $1 = "start" ]]; then
            start-enable-dockerd && echo " |- starting done."
        else
            echo " |- option : [start]"
        fi
    fi
}

# numeric checker
function is_number () {
    regex='^[0-9]+$'
    if ! [[ $1 =~ $regex ]];then
        echo false
    else
        echo true
    fi
}

# docker-compose getter file
function docker-compose-install () {
    target_dir=/usr/local/bin/docker-compose
    target_link_download="https://github.com/docker/compose/releases/download/1.23.2/docker-compose-$(uname -s)-$(uname -m)"

    echo "|- getting started to get docker-compose binary file.."
    if [[ $(curl -L $target_link_download -o $target_dir > /dev/null 2>&1 ;echo $?) -gt 0 ]]; then
        echo "|-- error : $?"
    else
        echo "|-- successful get file docker-compose installer"
        ls $target_dir | grep docker-compose
        echo "|- making permission to execute"
        if [[ $(chmod +x /usr/local/bin/docker-compose > /dev/null 2>&1 ;echo $?) -gt 0 ]]; then
            echo "|-- changing permission failed"
        else
            echo "|-- changing permission success"
            echo "|- linking to /usr/bin/"
            if [[ $(ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose > /dev/null 2>&1 ;echo $?) -gt 0 ]]; then
                echo "|-- error linking binary file"
            else
                echo "|-- docker-compose binary linked"
            fi
        fi
        echo "|- install docker-compose done"
    fi
}

# docker-compose checker is Exist 
function ishas-docker-compose () {
    function is-exist-dcfile () {
        ls $1 | grep docker-compose > /dev/null ;echo $?
    }
    is_exist_local=$(is-exist-dcfile /usr/local/bin/)
    echo $is_exist_local
    is_exist_global=$(is-exist-dcfile /usr/bin/)
    echo $is_exist_global
    if [[ $is_exist_local -eq 0 ]] || [[ $is_exist_global -eq 0 ]]; then
        echo true # exist
    else
        echo false # doesnt exist
    fi
}

# systemctl checker
function systemctl-check () {
    status = $(systemctl -h > /dev/null 2>&1 ;echo $?)
    if [[ $status -gt 0 ]]; then
        echo "not-installed"
    else
        echo "installed"
    fi 
}