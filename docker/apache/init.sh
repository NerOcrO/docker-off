#!/bin/sh

set -e

echo "\033[32m------------------ 1/ Retrieve products -----------------\033[0m";
wget https://static.openfoodfacts.org/exports/39-.tar.gz
tar -xzvf 39-.tar.gz -C products
rm 39-.tar.gz

echo "\033[32m------------------ 2/ Retrieve images -------------------\033[0m";
wget https://static.openfoodfacts.org/exports/39-.images.tar.gz
tar -xzvf 39-.images.tar.gz -C html/images/products
rm 39-.images.tar.gz

echo "\033[32m------------------ 3/ Import translations ---------------\033[0m";
scripts/build_lang.pl

echo "\033[32m------------------ 4/ Import products -------------------\033[0m";
scripts/update_all_products_from_dir_in_mongodb.pl

echo "\033[32m------------------ 5/ Retrieve top translators ----------\033[0m";
wget -P html/data https://static.openfoodfacts.org/data/top_translators.csv

echo "\033[32m------------------ 6/ Change owner ----------------------\033[0m";
chown -R www-data:www-data .

echo "\033[32m------------------ 7/ Restart Apache2 -------------------\033[0m";
apache2ctl -k graceful
