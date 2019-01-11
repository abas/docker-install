# Docker Compose Laravel + NGINX

> Instruction
- copy all file except `README.MD` to you project
- open `docker-compose.yml` there is something you need to configure like name of apps, and database connection
- open `vhost.conf` to make sure you have correct apps to mounting with

is all of it's to be `done`, then you can deploy your laravel project with single run command
```bash
    $ docker-compose up -d
```

if you have not composer on your `host/local` use this methode to get `vendor/composer_packages` composer
```bash
    $ docker run --rm -v path/to/project:/app composer/composer install --no-dev
    # `path/to/project/dir` is your own directory apps
    # --no-dev is optional if local development
    # if you production, you should be with `--no-dev`
```

if you haven't yet project, try to create project with this method
```bash
    $ docker run --rm -v path/to/project:/app composer/composer create-project laravel/laravel --no-dev project_name "version"
    # version example "5.4.*"
```