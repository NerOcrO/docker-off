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
- `echo -e "\n127.0.0.1 openfoodfacts.localhost" | sudo tee -a /etc/hosts`
- `sudo chown www-data:www-data openfoodfacts-server && sudo chown www-data:www-data openfoodfacts-server/users && sudo chown www-data:www-data openfoodfacts-server/tmp && sudo chown -R www-data:www-data openfoodfacts-server/html/images/products`
- `docker-compose up`
- Open a new bash
- `docker exec -it apache ./scripts/build_lang.pl`
- `docker exec -it apache ./scripts/update_all_products_from_dir_in_mongodb.pl`
- `sudo chown -R www-data:www-data openfoodfacts-server/products && sudo chmod -R 774 openfoodfacts-server/products`
- `docker exec -it apache apache2ctl -k restart`
- transform the symlink html/bower_components by a simple directory

# Test

## URL

- http://world.openfoodfacts.localhost:8081 (nginx)
- http://world.openfoodfacts.localhost:8080/cgi/display.pl (Apache)

## Edit CSS/JS

- `yarn run build`

## Start the container

- `docker-compose up`
- `docker-compose up -d` (deamon mode)

# Useful commands for debugging

- `docker logs apache|nginx|mongo`
- `docker exec -it apache|nginx|mongo bash`
- `docker exec -it apache apache2ctl -k graceful`
- `docker exec -it nginx nginx -s reload`
- `docker exec -it mongo mongo`
- `docker kill apache|nginx|mongo`

# Versions

- `docker --version` : Docker version 18.09.0, build 4d60db4
- `apache2 -v` : Apache/2.4.25
- `perl -v` : This is perl 5, version 24, subversion 1 (v5.24.1) built for x86_64-linux-gnu-thread-multi
- `cpan -D Log::Any` (module version)
- `cpan -O` (out-of-date modules)
- https://github.com/openfoodfacts/openfoodfacts-server/network/dependencies  
