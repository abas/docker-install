# Docker Compose Laravel + NGINX

> Instruction
- copy all file except `README.MD` to you project
- open `docker-compose.yml` there is something you need to configure like name of apps, and database connection
- open `vhost.conf` to make sure you have correct apps to mounting with

is all of it's to be `done`, then you can deploy your laravel project with single run command
```bash
    $ docker-compose up -d
```