# Docker MongoDB + Mongo-Express Dashboard

> How to run `MongoDB` container

```bash
    # open mongodb-stack.yml 
    # configure your own
    $ docker-compose -f mongodb-stack.yml up -d
```

> How to run `Mongo-Express` container

```bash
    $ docker-compose -f mongoexpress-stack.yml
```

> Note

you can `expose` or `disexpose` port by editing ***-stack.yml** on colom `port`