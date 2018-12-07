FROM debian:stretch-slim

ARG off_root

WORKDIR $off_root

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
    libapache2-mod-php \
    libexpat1-dev \
    libzbar-dev \
    make \
    perlmagick \
    tesseract-ocr \
    wget \
  && cpanm --notest --quiet --skip-satisfied inc::Module::Install@1.19 \
  && cpanm --notest --quiet --skip-satisfied --installdeps . \
  && cd .. \
  && wget https://github.com/elijaa/phpmemcachedadmin/archive/1.3.0.tar.gz \
  && tar -xvzf 1.3.0.tar.gz \
  && rm 1.3.0.tar.gz \
  && chmod -R +rx phpmemcachedadmin-1.3.0/* \
  && chmod 777 phpmemcachedadmin-1.3.0/Temp phpmemcachedadmin-1.3.0/stats.php \
  && apt-get remove -y \
    g++ \
    gcc \
    make \
    wget \
  && apt-get purge -y --auto-remove \
  && rm -rf /var/lib/apt/lists/* ~/.cpanm /root/.cpanm /usr/src/perl /tmp/*

ENTRYPOINT ["apache2ctl", "-DFOREGROUND"]
