# Install Docker

- Docker CE: https://docs.docker.com/install/#supported-platforms
- Docker Compose: https://docs.docker.com/compose/install/

# Documentations

- https://docs.docker.com/reference/ (CLI)
- https://docs.docker.com/engine/reference/builder/ (Dockerfile)
- https://docs.docker.com/compose/compose-file/ (docker-compose)

# How to setup the container

## Unix

- `sudo apt install git yarn wget tar nodejs` (if you don't have it) (node < 11)
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

## Simulate many connection

`docker exec -it apache ab -c 20 -n 1000 http://localhost:8080/`

# Versions used

- `docker --version` : Docker version 18.09.0, build 4d60db4
- `apache2 -v` : Apache/2.4.25
- `perl -v` : This is perl 5, version 24, subversion 1 (v5.24.1) built for x86_64-linux-gnu-thread-multi
- https://github.com/openfoodfacts/openfoodfacts-server/network/dependencies  

# Blocking issue

- https://github.com/tbenett/cpp-creation-file-class/blob/eda4cec24329b84ca34c848a29f855a01f76e295/templ#L28
- fichier de conf memcached
- mettre un volume sur les données mongodb et fichier de conf
-- cat /data/db/
- utiliser sed avec une expression régulière qui change toutes les ENV de la conf nginx pour utiliser l'image alpine
- ELK
-- fichiers de conf en volume
-- bdd ES en volume
-- faire un tdb comme https://www.awstats.org/
- second apache et loadbalancer ?
- faire https://github.com/NerOcrO/stack et mettre des versions et taille js/css pour démontrer certaines choses

# Improvements Docker

- http2
-- cf docker existant
-- lego/caddy
-- https://github.com/lesspass/lesspass
- Supprimer les warning mongodb
- Partir d'autre chose que Debian (767Mo)
-- Perl/httpd : faut installer libapache2-mod-perl2 à la main
-- Alpine : faut installer cpanminus et libapache2-mod-perl2 à la main
--- https://pkgs.alpinelinux.org/packages
- ajouter http://munin-monitoring.org/ + sondes
- la redirection sans www ne fonctionne pas quand il y a un port
-- Vu que c'est le port ouvert pour le host, je ne peux pas le gérer dans la conf nginx mais ce n'est pas très grave vu que c'est juste pour la prod (on peut tester que cette rule fonctionne en mettant 80)

# Improvements OFF

- tester la branche webpack
-- https://securityheaders.com/?q=https%3A%2F%2Fworld.openfoodfacts.org%2F&followRedirects=on
-- Filename-based cache busting : https://github.com/h5bp/server-configs-nginx/blob/master/h5bp/location/web_performance_filename-based_cache_busting.conf
-- bloquer http://world.openfoodfacts.localhost/css|data|js|.../ et faire une PR
-- Remove old Content-Security-Policy
- Deux fois les même warnings IsEmail au démarrage d'Apache
-- Supprimer les use doublon mais dépendances circulaires difficile
- Utilité de manifest.pl ?
- Replace Config2_sample_docker.pm by environement variables
-- https://12factor.net/config
-- https://artisandeveloppeur.fr/les-12-facteurs-de-scalabilite-avec-christophe-chaudier/

# Webpack

npm install -g pnpm
pnpm install
pnpm run dev

- tester les scripts

# LIB JS
- jquery.tagsinput.20160520/*
-- ./cgi/product_multilingual.pl
- canvas-to-blob.min.js
-- ./lib/ProductOpener/Images.pm
-- ./cgi/product_multilingual.pl
-- ./cgi/madenearyou.pl
-- ./madenearme/madenearme-fr.html
- datatables.min.js
-- ./lang/ar/texts/*
-- ./lib/ProductOpener/Display.pm
-- ./scripts/gen_top_tags.pl
-- ./scripts/gen_top_tags_per_country.pl
-- ./scripts/gen_sugar.pl
-- ./cgi/top_translators.pl
- highcharts.4.0.4.js
-- ./lib/ProductOpener/Display.pm
-- ./scripts/gen_top_tags.pl
-- ./scripts/gen_top_tags_per_country.pl
- jquery.autoresize.js
-- ./cgi/product_multilingual.pl
- jquery.fileupload.min.js
-- ./html/js/jquery.fileupload-ip.min.js
-- ./html/js/jquery.fileupload-ip.js
-- ./lib/ProductOpener/Images.pm
-- ./cgi/product_multilingual.pl
-- ./cgi/madenearyou.pl
-- ./madenearme/madenearme-fr.html
- jquery.fileupload-ip.min.js
-- ./lib/ProductOpener/Images.pm
-- ./cgi/product_multilingual.pl
-- ./cgi/madenearyou.pl
-- ./madenearme/madenearme-fr.html
- jquery.form.js
-- ./cgi/product_multilingual.pl
- jquery.iframe-transport.min.js
-- ./lib/ProductOpener/Images.pm
-- ./cgi/product_multilingual.pl
-- ./cgi/madenearyou.pl
-- ./madenearme/madenearme-fr.html
- jquery.nivo.zoom.pack.js
-- ./scripts/gen_sucres.pl
-- ./scripts/gen_sugar.pl
- jquery-jvectormap-1.2.2.min.js
-- ./lib/ProductOpener/Display.pm
- jquery-jvectormap-world-mill-en.js
-- ./lib/ProductOpener/Display.pm
- jQueryRotateCompressed.2.1.js
-- ./cgi/product_multilingual.pl
- load-image.min.js
-- ./lib/ProductOpener/Images.pm
-- ./cgi/product_multilingual.pl
-- ./cgi/madenearyou.pl
-- ./madenearme/madenearme-fr.html
- sigma.forceatlas2.js
-- ./lang/fr/texts/graphe-des-categories.html
- sigma.min.js
-- ./lang/fr/texts/graphe-des-categories.html
- sigma.parseGexf.js
-- ./lang/fr/texts/graphe-des-categories.html

OFF
- display-tag
-- ./lib/ProductOpener/Display.pm
- product-multilingual
-- ./cgi/product_multilingual.pl
- search.js
-- ./cgi/search.pl
