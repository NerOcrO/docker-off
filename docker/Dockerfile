FROM debian:stretch

ENV OFF_ROOT=/var/www/html

WORKDIR $OFF_ROOT

COPY cpanfile .

RUN apt-get update && apt-get install -y \
    apache2 \
    apt-utils \
    cpanminus \
    g++ \
    gcc \
    graphviz \
    imagemagick \
    libapache2-mod-perl2 \
    libexpat1-dev \
    libzbar-dev \
    make \
    perlmagick \
    tesseract-ocr \
  && cpanm --notest --quiet --skip-satisfied inc::Module::Install@1.19 \
  && cpanm --notest --quiet --skip-satisfied --installdeps . \
  && apt-get remove -y \
    g++ \
    gcc \
    make \
  && apt-get purge -y --auto-remove \
  && rm -rf /var/lib/apt/lists/* ~/.cpanm /root/.cpanm /usr/src/perl /tmp/*

ENV PERL5LIB=$OFF_ROOT/lib
ENV OFF_DOCUMENT_ROOT=$OFF_ROOT/html
ENV OFF_SERVER_NAME=openfoodfacts.localhost
ENV OFF_SSL_SUBDOMAINS=*
ENV OFF_MONGODB_USER=off
ENV OFF_MONGODB_HOST=mongodb://mongo
ENV OFF_MEMCACHE_SERVERS=127.0.0.1:11211
ENV OFF_APACHE_PORT=8080
ENV OFF_SERVER_ADMIN=contact@openfoodfacts.org

ENTRYPOINT ["apache2ctl", "-DFOREGROUND"]
