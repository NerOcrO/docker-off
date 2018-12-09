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

echo "\033[32m------------------ 2/ Creating directories --------------\033[0m";
cd openfoodfacts-server
mkdir -p html/data/mongo html/images/products logs products tmp users

echo "\033[32m------------------ 3/ File configuration ----------------\033[0m";
cp lib/ProductOpener/Config2_sample.pm lib/ProductOpener/Config2_sample_docker.pm
$sed -i \
  -e 's|$server_domain = "openfoodfacts.org";|$server_domain = "openfoodfacts.localhost:8081";|' \
  -e 's|"/home/off/html"|"/var/www/html/html"|' \
  -e 's|"/home/off"|"/var/www/html"|' \
  -e 's|"mongodb://localhost"|"mongodb://mongo"|' \
  -e 's|"127.0.0.1:11211"|"memcached:11211"|' \
  -e 's|*|no|' \
  lib/ProductOpener/Config2_sample_docker.pm
  # -e 's|$server_domain = "openfoodfacts.org";|$server_domain = $ENV{"OFF_SERVER_NAME"};|' \
  # -e 's|"/home/off/html"|$ENV{"OFF_DOCUMENT_ROOT"}|' \
  # -e 's|"/home/off"|$ENV{"OFF_ROOT"}|' \
  # -e 's|"off"|$ENV{"OFF_MONGODB_USER"}|' \
  # -e 's|"mongodb://localhost"|$ENV{"OFF_MONGODB_HOST"}|' \
  # -e 's|"127.0.0.1:11211"|$ENV{"OFF_MEMCACHE_SERVERS"}|' \

echo "\033[32m------------------ 4/ Retrieve products -----------------\033[0m";
wget https://static.openfoodfacts.org/exports/39-.tar.gz
tar -xzvf 39-.tar.gz -C products
rm 39-.tar.gz

echo "\033[32m------------------ 5/ Retrieve images -------------------\033[0m";
wget https://static.openfoodfacts.org/exports/39-.images.tar.gz
tar -xzvf 39-.images.tar.gz -C html/images/products
rm 39-.images.tar.gz

echo "\033[32m------------------ 6/ Retrieve top translators ----------\033[0m";
wget -P html/data https://static.openfoodfacts.org/data/top_translators.csv

echo "\033[32m------------------ 7/ Yarn configuration-----------------\033[0m";
yarn install
yarn run build

echo "\033[32m------------------ 8/ Docker compose --------------------\033[0m";
cd -
docker-compose build
