# Docker NodeJS | Express sample
Dockerize your nodeapps project :>
some environment may use with node include npm pm2 etc. but now we can just deploy it with `docker`:[reference](https://docs.docker.com) :>

on usually.. some basic nodejs project like an express is default serve `index.js` but some other remake that with own their like, so we can assume that is simple diffrent. You may can understand if you try documentation of [express](https://expressjs.com) and may other framework look like.

## Creating New NodeJS Project 
simply,. the host with node/npm binary or we can just call it node and npm installed, can create project by command `npm init -y`. so how docker can create project by the way? :> do not confuse with small thing like that :v docker also have their way to create project with no environment installed on their host. if on host env we can just run `npm init -y` also docker have a way to do that. but first we must own `docker images` :> 

> Project Structure will be
```txt
.../service
  ../
  |- simple-apps/
    | node_modules/
    |- package.json
    |- index.js
    .
    |- etc
    .
  |- Dockerfile
  |- docker-compose.yml
  .
  .
  |- etc
...
```

### Build Images
we can pull existing images from [dockerhub](https://hub.docker.com) and modify that, so we can use our image according to the needs.
the `Dockerfile` will be look like bellow
```Dockerfile
FROM node:8

LABEL kankuu <akhmadbasir5@gmail.com>

RUN echo "|----> updating repository" \
  && apt-get update -y \
  && echo "|----> successfull update" \
  || echo "|----> failed to update"

RUN echo "|----> installing tool" \
  && apt-get install -y \
  # add tool here
  nano \
  && echo "|----> successfull installing tool" \
  || echo "|----> failed to install tool"

RUN mkdir /app
WORKDIR /app

EXPOSE 3000
```

> Building Images

```bash
  # basic
  $ docker build -f /path/to/Dockerfile -t username/images:tag .

  # assume we can define
  # username : kankuu
  # images : nodeapps
  # tag : dev
  # so the command should be like this
  $ docker build -f Dockerfile -t kankuu/nodeapps:dev .
```
now we have new images called `kankuu/nodeapps` with tag name `dev`, you can push images to dockerhub or just save to your local machine :>
i am prefer to push that image, because if we lost our images we can just pull it again :> happy pulling images :>

> Creating Project
we have images, and we have access local to use that. so on other way to make new project we can use command bellow.
```bash
  $ mkdir sample-apps && cd sample-apps
  $ docker run -ti --rm -v $(pwd)/:/app kankuu/nodeapps:dev npm init -y

  # then to installing package node
  $ docker run -ti --rm -v $(pwd)/:/app kankuu/nodeapps:dev npm install
```
how about if you have existing project? :> dont worry my brother :> let sing and song :> ehehe :D \*sorry
if you have an existing project and want to install package, just run command bellow.
```bash
  $ docker run -ti --rm -v $(/path/to/project):/app kankuu/nodeapps:dev npm install
  # then see your project, new folder created there :> `node_modules`
```

## Deploy NodeJS Apps
... to be continue