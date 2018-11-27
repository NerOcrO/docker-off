# Install Docker

- Docker CE: https://docs.docker.com/install/#supported-platforms
- Docker Compose: https://docs.docker.com/compose/install/

# How to setup the container

- `netstat -tulpn | grep :80` (free your port 80 please: Apache or Nginx)
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
- `docker kill apache|nginx|mongo`

# Useful commands for debugging

- `docker exec -it apache|nginx|mongo bash`
- `docker logs apache|nginx|mongo`
- `docker exec -it apache apache2ctl -k restart`
- `docker exec -it nginx nginx -s reload`
- `docker exec -it mongo mongo`

# Documentations

- https://docs.docker.com/reference/ (CLI)
- https://docs.docker.com/engine/reference/builder/ (Dockerfile)
- https://docs.docker.com/compose/compose-file/ (compose)
- http://nginx.org/en/docs/http/ngx_http_core_module.html
- https://perl.apache.org/docs/2.0/user/handlers/http.html
- https://perl.apache.org/docs/2.0/user/config/config.html
- https://metacpan.org/pod/cpanm
- https://perlmaven.com/
- http://deb.perl.it/

# Versions

- `docker --version` : Docker version 18.09.0, build 4d60db4
- `apache2 -v` : Apache/2.4.25
- `perl -v` : This is perl 5, version 24, subversion 1 (v5.24.1) built for x86_64-linux-gnu-thread-multi
- `cpan -D Log::Any` (module version)
- `cpan -O` (out-of-date modules)
- https://github.com/openfoodfacts/openfoodfacts-server/network/dependencies  

# Blocking issue

- faire https://github.com/NerOcrO/stack et mettre des versions et taille js/css pour démontrer certaines choses
- GraphViz2 a encore planté chez William

# Improvements Docker

- Pourquoi 8081 ne fonctionne pas pour static. ?
- Pourquoi mon image fait 924Mo ?
- Pourquoi des fois ça rame de ouf ?
-- Sans Apache2::Reload, c'est mieux mais avec htop, je vois que /usr/sbin/apache2 -DFOREGROUND prend tout le CPU
- https://docs.docker.com/develop/develop-images/dockerfile_best-practices/
-- revoir 'Use multi-stage builds' et 'Minimize the number of layers'
- Découpler apache(http?) et perl ?
- Removing 'libbarcode-zbar-perl libimage-magick-perl libxml-encoding-perl' and put them into cpanfile
- http2
- memcache ?
- ajouter `restart: always` dans docker-compose quand tout sera OK
- https://github.com/docker-library/docs/tree/master/nginx#using-environment-variables-in-nginx-configuration
- Pourquoi les logs apache/nginx ne s'affichent plus ?
-- Apache : cf logs/modperl_error_log
-- nginx : cf logs/nginx....log

# Improvements OFF

- tester la branche webpack
-- https://securityheaders.com/?q=https%3A%2F%2Fworld.openfoodfacts.org%2F&followRedirects=on
-- Filename-based cache busting : https://github.com/h5bp/server-configs-nginx/blob/master/h5bp/location/web_performance_filename-based_cache_busting.conf
-- bloquer http://world.openfoodfacts.localhost/css|data|js|.../ et faire une PR
-- Remove old Content-Security-Policy
- https://amplify.nginx.com/signup/
-- https://github.com/nginxinc/docker-nginx-amplify
- Checker error au lancement de Apache et les fichiers de log
- revoir My::ProxyRemoteAddr
- startup_apache2.pl est lancé deux fois ? car j'ai deux fois les même erreurs
-- appel I18N.pm(split_tags), IsEmail.pm
-- puis Tags.pm(opendir DH2...), I18N.pm(split_tags), IsEmail.pm
- Extract mkdir out of repo
- Replace Config2_sample_docker.pm by environement variables
-- https://12factor.net/config
-- http://artisandeveloppeur.fr/les-12-facteurs-de-scalabilite-avec-christophe-chaudier/
