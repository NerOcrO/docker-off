#!/bin/sh

set -e

# Mac OS needs gsed.
if [ $(uname) == "Darwin" ]; then
  sed=gsed
else
  sed=sed
fi

echo "\033[32m------------------ 1/ Cloning OFF -----------------------\033[0m";
git clone git@github.com:openfoodfacts/openfoodfacts-server.git

echo "\033[32m------------------ 2/ File configuration ----------------\033[0m";
cd openfoodfacts-server
cp lib/ProductOpener/Config2_sample.pm lib/ProductOpener/Config2.pm
$sed -i \
  -e 's|$server_domain = "openfoodfacts.org";|$server_domain = "openfoodfacts.localhost";|' \
  -e 's|"/home/off/html"|"/var/www/html/html"|' \
  -e 's|"/home/off"|"/var/www/html"|' \
  -e 's|"mongodb://localhost"|"mongodb://mongo"|' \
  -e 's|"127.0.0.1:11211"|"memcached:11211"|' \
  -e 's|*|no|' \
  lib/ProductOpener/Config2.pm
  # -e 's|$server_domain = "openfoodfacts.org";|$server_domain = $ENV{"OFF_SERVER_NAME"};|' \
  # -e 's|"/home/off/html"|$ENV{"OFF_ROOT"}/html|' \
  # -e 's|"/home/off"|$ENV{"OFF_ROOT"}|' \
  # -e 's|"off"|$ENV{"OFF_MONGODB_USER"}|' \
  # -e 's|"mongodb://localhost"|$ENV{"OFF_MONGODB_HOST"}|' \
  # -e 's|"127.0.0.1:11211"|$ENV{"OFF_MEMCACHE_SERVERS"}|' \

echo "\033[32m------------------ 3/ Yarn configuration-----------------\033[0m";
yarn install
yarn run build
rm html/bower_components && cp -r node_modules/@bower_components html/bower_components

echo "\033[32m------------------ 4/ Docker build ----------------------\033[0m";
cd -
docker-compose build
