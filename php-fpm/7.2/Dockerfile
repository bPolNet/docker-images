FROM php:7.2.24-fpm

MAINTAINER Konrad Podgórski <konrad.podgorski@gmail.com>

RUN apt-get update -yqq \
    && apt-get install git zlib1g-dev git zip unzip libmemcached11 libmemcachedutil2 libmemcached-dev -y \
    && docker-php-ext-install zip \
    && docker-php-ext-install pdo_mysql

RUN git clone https://github.com/php-memcached-dev/php-memcached /usr/src/php/ext/memcached \
  && cd /usr/src/php/ext/memcached && git checkout -b php7 origin/php7 \
  && docker-php-ext-configure memcached \
  && docker-php-ext-install memcached

RUN docker-php-ext-install opcache \
  && docker-php-ext-enable opcache

RUN pecl install apcu  \
  && docker-php-ext-enable apcu

# GD extension
RUN apt-get install -y libpng-dev \
    && docker-php-ext-install gd

# EXIF extension
RUN docker-php-ext-install exif

# make production version
RUN mv /usr/local/etc/php/php.ini-production /usr/local/etc/php/php.ini

WORKDIR /var/www

RUN usermod -u 1000 -s /bin/bash www-data

USER www-data

EXPOSE 9000
