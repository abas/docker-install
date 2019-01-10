# Docker single run Install
the purpose of the project is to simplify docker install with just running single file

> how to use

``` bash
    # clone this repo and enter on the project
    $ git clone {repo_url}
    $ cd docker-install
    $ chmod +x *
    
    # install docker
    $ ./docker-install.sh [-base_os] # or you can with `bash docker-install.sh`
```

> Note

docker-installer command option
``` bash
    $ command [option]
    - option : 
        -debian <- base OS debias .deb specify
        -fedora <- base OS fedora like centos etc
        -ubuntu <- base OS ubuntu
    ex :
    $ ./docker-installer.sh -debian # for fedora
    $ ./docker-installer.sh -fedora # for fedora
    $ ./docker-installer.sh -ubuntu # for fedora
```

> Note II
don't hesitate to make `issue` :>
