# Docker single run Install
the purpose of the project is to simplify docker install with just running single file

### Included
= database `mysql` compose
- `laravel` compose
- `composer` docker command

> how to use

``` bash
    # clone this repo and enter on the project
    $ git clone {repo_url}
    $ cd docker-install
    $ chmod +x * && sudo su # don't forger we must access with root
    
    # install docker
    $ ./docker-install.sh [-base_os] --default # or you can with `bash docker-install.sh`

    # install portainer, docker container management
    $ ./docker-install.sh [-base_os] --add portainer # port is optional, default 9000, container name is portainer

    # portainer with custom `port` / `container name`
    $ ./docker-install.sh [-base_os] --add portainer [port] # port is optional, default 9000
    $ ./docker-install.sh [-base_os] --add portainer [container_name] # port is optional, default 9000
    $ ./docker-install.sh [-base_os] --add portainer [container_name] [port] # port is optional, default 9000
```

> Note
- `--default` will install docker only

docker-installer command option
``` bash
    $ command [option_os] --default
    - option : 
        -debian <- base OS debias .deb specify
        -fedora <- base OS fedora like centos etc
        -ubuntu <- base OS ubuntu
    ex :
    $ ./docker-installer.sh -debian --default # for debias
    $ ./docker-installer.sh -fedora --default # for fedora
    $ ./docker-installer.sh -ubuntu --default # for ubuntu
```

> Next Objective

- `docker-compose` installer
- `add` progressbar
- `refactor` docker-install.sh with functionable structure

> Note End
don't hesitate to make `issue` :>
