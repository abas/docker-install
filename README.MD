# Docker single run Install
the purpose of the project is to simplify docker install with just running single file

### Included
- database `mysql` compose
- `laravel` compose
- `composer` docker command
- `docker-compose` installer
- `portainer` installer

> how to install `Docker`

``` bash
    # clone this repo and enter on the project
    $ git clone {repo_url}
    $ cd docker-install
    $ chmod +x * && sudo su # don't forger we must access with root
    
    # install docker
    $ ./docker-install.sh [-base_os] --default # or you can with `bash docker-install.sh`
```

> Note
- `--default` will install docker only
- if there any `errors` on your progress, try running with root previllage.

> how to install docker `Portainer`

```bash
    # install portainer, docker container management
    $ ./docker-install.sh [-base_os] --add portainer # port is optional, default 9000, container name is portainer

    # portainer with custom `port` / `container name`
    $ ./docker-install.sh [-base_os] --add portainer [port] # port is optional, default 9000
    $ ./docker-install.sh [-base_os] --add portainer [container_name] # port is optional, default 9000
    $ ./docker-install.sh [-base_os] --add portainer [container_name] [port] # port is optional, default 9000
```

> how to install `docker-compose`

```bash
    $ ./docker-install.sh [-base_os] --add docker-compose
    # this feature is support on linux, and also mac :> could it be ?
```

docker-installer command option
```bash
    $ command [-base_os] --default
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

- [ ] compose `node-apps`
- [X] `docker-compose` installer
- [ ] `add` progressbar
- [ ] `refactor` docker-install.sh with functionable structure

> Note End

<kankuu> don't hesitate to make `issue` and `pull request` :>
