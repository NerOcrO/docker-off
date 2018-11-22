# Install Docker

- Docker CE: https://docs.docker.com/install/#supported-platforms
- Docker Compose: https://docs.docker.com/compose/install/

# How to setup the container

- Free your port 80
- You need git, yarn, wget and tar
- `./docker/build.sh` (~20 minutes)
- `echo -e "\n127.0.0.1 off.localhost" | sudo tee -a /etc/hosts`
- `docker-compose up`
- Open a new bash
- `docker ps`
- `docker exec -it [APACHE_CONTAINER_NAME] ./scripts/build_lang.pl`
- `docker exec -it [APACHE_CONTAINER_NAME] ./scripts/update_all_products_from_dir_in_mongodb.pl`
- Turn off the old container
- `docker-compose up`

# Test

## URL

- http://world.off.localhost:8081 (nginx)
- http://world.off.localhost:8080/cgi/display.pl (Apache)

## Edit CSS/JS

- `yarn run build`

## Start the container

- `docker-compose up`

# Useful commands for debugging

- `docker exec -it [CONTAINER_NAME] bash`
- `docker logs [CONTAINER_NAME]`

# Documentations

- https://docs.docker.com/reference/ (CLI)
- https://docs.docker.com/engine/reference/builder/ (Dockerfile)
- https://docs.docker.com/compose/compose-file/ (compose)
- http://nginx.org/en/docs/http/ngx_http_core_module.html
- http://httpd.apache.org/docs/current/en/mod/core.html
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
- Foundation : 5.5.3

# Blocking issue

- 'html/bower_components' doesn't work
-- Il faut supprimer le lien symbolique et tout mettre dans un seul fichier JS
-- solution temporaire : copier bower_components/ à la place du lien symbolique du même nom

# Improvements Docker

- Pourquoi mon image fait 924Mo ?
- Découpler apache(http?) et perl ?
- Redirection off.localhost to world.off.localhost
- lire les best practices
-- https://docs.docker.com/develop/develop-images/dockerfile_best-practices/
-- revoir 'Use multi-stage builds' et 'Minimize the number of layers'
- Removing 'libbarcode-zbar-perl libimage-magick-perl libxml-encoding-perl' and put them into cpanfile
- ajouter `restart: always` dans docker-compose quand tout sera OK
- https
- memcache ?

# Improvements OFF

- Checker error au lancement de Apache et les fichiers de log
- revoir My::ProxyRemoteAddr
- startup_apache2.pl est lancé deux fois ? car j'ai deux fois les même erreurs
-- appel I18N.pm(split_tags), IsEmail.pm
-- puis Tags.pm(opendir DH2...), I18N.pm(split_tags), IsEmail.pm
- Extract mkdir out of repo
- Replace Config2_sample_docker.pm by environement variables
-- https://12factor.net/config
-- http://artisandeveloppeur.fr/les-12-facteurs-de-scalabilite-avec-christophe-chaudier/

rajouter #issue

LIB
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
