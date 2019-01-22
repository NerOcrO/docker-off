# Why and what is Docker

Docker is the easiest way to install the Open Food Facts server, play with it, and even modify the code.

Docker provide an isolated environnement, very close to a Virtual Machine. This environnement contains everything needed to launch the Open Food Facts server. There IS NO NEED TO INSTALL Perl, Perl modules, nor Nginx nor Apache.

- [Get started with Docker](https://www.docker.com/get-started)
- [Qu'est-ce que Docker et comment l'utiliser](https://www.youtube.com/watch?v=XgKOC6X8W28)

# Install Docker

- [Docker CE](https://docs.docker.com/install/#supported-platforms)
- [Docker Compose](https://docs.docker.com/compose/install/)

# Documentations

- [CLI](https://docs.docker.com/reference/)
- [Dockerfile](https://docs.docker.com/engine/reference/builder/)
- [docker-compose](https://docs.docker.com/compose/compose-file/)

# Prerequisite

- [GIT](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)
- [Yarn](https://yarnpkg.com/lang/en/docs/install/)
- [Node.js](https://nodejs.org/en/download/package-manager/) (version < 11)
- SSH and [a public key to your GitHub account](https://help.github.com/articles/which-remote-url-should-i-use/#cloning-with-ssh-urls)

# How to setup the container

## Unix

This instructions build the environement. If every commands end well, they don't have to be repeated.

- `./docker/build.sh` (~20 minutes)
- `docker-compose up`
- Open a new bash
- `echo -e "\n127.0.0.1 openfoodfacts.localhost static.openfoodfacts.localhost world.openfoodfacts.localhost fr.openfoodfacts.localhost" | sudo tee -a /etc/hosts`
- `docker exec -it apache /opt/init.sh` (install a test database with 117 products)

# Basic usage

## The Open Food Facts server is ready to use. **URL to test**

- http://world.openfoodfacts.localhost/ (Nginx)
- http://world.openfoodfacts.localhost:8080/cgi/display.pl (Apache)
- http://localhost:5601/ (Kibana)
- http://localhost:9200/ (Elasticsearch)
- http://localhost:8082/ (PHPMemcachedAdmin)

After the setup, if you reboot your computer or kill the containers process, you will have to restart at least the 3 containers needed for Open Food Facts:

- `cd /path/towards/docker-off`
- `docker-compose up`

The Open Food Facts is ready to use again. The terminal can be closed but we suggest to keep it to read log informations.

There is two ways if you want to launch scripts "inside" the container:

- `docker exec -it apache [path_and_name_of_the_script]`
- `docket exec -it apache bash`

The second option open a bash environement inside the container.
You can modify the server sources inside `/path/towards/docker-off/openfoodfacts-server/`.

# Advanced usages

## Start the containers as deamon

`docker-compose up -d`

## Start the containers with another port

`OFF_NGINX_PORT_PUBLISHED=8083 docker-compose up`

## Start the containers with Memcached

`docker-compose -f docker-compose.yml -f docker-compose.memcached.yml up`

## Start the containers with ElasticsearchLogstashKibana

If you want to use ELK: [update your vm.max_map_count before](https://elk-docker.readthedocs.io/#prerequisites).

`docker-compose -f docker-compose.yml -f docker-compose.elk.yml up`

## Reload a server

`docker exec -it apache apache2ctl -k graceful`

`docker exec -it nginx nginx -s reload`

## Connect to the Mongo database

`docker exec -it mongo mongo`

## Kill a container

`docker kill apache|nginx|memcached|mongo`

## Build translations

`docker exec -it apache ./scripts/build_lang.pl`

`docker exec -it apache apache2ctl -k graceful`

## Run a test

`docker exec -it apache perl t/[TEST_FILENAME].t`

## Edit CSS/JS and build them

`yarn run build`

## Simulate many connection

`docker exec -it apache ab -c 20 -n 1000 http://localhost:8080/`

## Remove all processes

`docker container prune`

## Remove all volumes

`docker volume prune`

## Remove all containers

`docker rmi $(docker images -q)`

# Versions used

- `docker --version` : Docker version 18.09.0, build 4d60db4
- `apache2 -v` : Apache/2.4.25
- `perl -v` : This is perl 5, version 24, subversion 1 (v5.24.1) built for x86_64-linux-gnu-thread-multi
- https://github.com/openfoodfacts/openfoodfacts-server/network/dependencies
