# Install Docker

- Docker CE: https://docs.docker.com/install/#supported-platforms
- Docker Compose: https://docs.docker.com/compose/install/

# Documentations

- https://docs.docker.com/reference/ (CLI)
- https://docs.docker.com/engine/reference/builder/ (Dockerfile)
- https://docs.docker.com/compose/compose-file/ (docker-compose)

# How to setup the container

## Unix

- `sudo apt install git yarn wget tar` (if you don't have it)
- `./docker/build.sh` (~20 minutes)
- `docker-compose up`
- Open a new bash
- `echo -e "\n127.0.0.1 openfoodfacts.localhost" | sudo tee -a /etc/hosts`
- `sudo chown -R www-data:www-data openfoodfacts-server openfoodfacts-server/users openfoodfacts-server/tmp openfoodfacts-server/html/images/products`
- `sudo chown -R www-data:www-data openfoodfacts-server/products && sudo chmod -R 774 openfoodfacts-server/products`
- `docker exec -it apache ./scripts/build_lang.pl`
- `docker exec -it apache ./scripts/update_all_products_from_dir_in_mongodb.pl`
- `docker exec -it apache apache2ctl -k graceful`
- Transform the symlink html/bower_components by a simple directory

# Usage

## URL to test

- http://world.openfoodfacts.localhost:8081/ (Nginx)
- http://world.openfoodfacts.localhost:8080/cgi/display.pl (Apache)
- http://localhost:5601/ (Kibana)
- http://localhost:9200/ (Elasticsearch)
- http://localhost:8082/ (PHPMemcachedAdmin)

## Start the containers and see the logs

`docker-compose up`

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

# Versions used

- `docker --version` : Docker version 18.09.0, build 4d60db4
- `apache2 -v` : Apache/2.4.25
- `perl -v` : This is perl 5, version 24, subversion 1 (v5.24.1) built for x86_64-linux-gnu-thread-multi
- https://github.com/openfoodfacts/openfoodfacts-server/network/dependencies  
