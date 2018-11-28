FROM debian:stretch

RUN apt-get update && apt-get install -y \
    apache2 \
    cpanminus \
    g++ \
    gcc \
    graphviz \
    imagemagick \
    libapache2-mod-perl2 \
    make \
    tesseract-ocr \
    # TODO: Migrate to cpanfile.
    libbarcode-zbar-perl \
    libimage-magick-perl \
    libxml-encoding-perl \
  && apt-get purge -y --auto-remove \
  && rm -rf /var/lib/apt/lists/*

ENV OFF_ROOT=/var/www/html

WORKDIR $OFF_ROOT

COPY cpanfile .

RUN cpanm --notest --quiet --installdeps --skip-satisfied .

RUN rm -rf ~/.cpanm

COPY etc/apache2 /etc/apache2

RUN \
  a2enconf -q off.conf \
  && a2ensite -q off.conf

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
