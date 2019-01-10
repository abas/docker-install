# Docker single run Install
the purpose of the project is to simplify docker install with just running single file

> how to use

``` bash
    # clone this repo and enter on the project
    $ git clone {repo_url}
    $ cd docker-install
    $ chmod +x *
    
    # install docker
    $ ./docker-install.sh [-base_os] --default # or you can with `bash docker-install.sh`

    # install portainer, docker container management
    $ ./docker-install.sh [-base_os] --add portainer [port] # port is optional, default 9000
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

> Note End
don't hesitate to make `issue` :>
