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

RUN apt-get update && apt-get install -y nginx supervisor

ADD etc /etc/

RUN echo "memory_limit = 512M" >> /usr/local/etc/php/conf.d/memory_limit.ini
ADD etc/php/conf.d /usr/local/etc/php/conf.d/

# let php-fpm access env variables
RUN sed -i 's/;clear_env = no/clear_env = no/g' /usr/local/etc/php-fpm.d/www.conf

RUN rm /etc/nginx/sites-enabled/default
RUN ln -s /etc/nginx/sites-available/default.conf /etc/nginx/sites-enabled/default.conf

RUN usermod -u 1000 -s /bin/bash www-data


# php7.2 libmcrypt
RUN apt-get update && apt-get install -y libmcrypt-dev && \
    pecl install mcrypt-1.0.1 && \
    docker-php-ext-enable mcrypt

# php7.2 calendar
RUN docker-php-ext-configure calendar && docker-php-ext-install calendar

# php7.2 INTL
RUN apt-get update && apt-get install libicu-dev -y \
    && docker-php-ext-install intl

# php7.2 SOAP
RUN apt-get update && apt-get install libxml2 libxml2-dev -y \
    && docker-php-ext-install soap

# PDF generation
ENV WKHTMLTOPDF_VERSION 0.12.5
RUN curl -L -o wkhtmltox.deb https://github.com/wkhtmltopdf/wkhtmltopdf/releases/download/${WKHTMLTOPDF_VERSION}/wkhtmltox_${WKHTMLTOPDF_VERSION}-1.stretch_amd64.deb
RUN apt-get install ./wkhtmltox.deb -y && rm ./wkhtmltox.deb
RUN apt-get install libxrender1 -y

# text editors
RUN apt-get update && apt-get install vim nano -y

# needed by cloud print
RUN apt-get update && apt-get install procps -y

# Install GD
RUN apt-get update && apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libpng-dev \
    && docker-php-ext-install -j$(nproc) iconv \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd

# Redis extension
RUN pecl install redis && docker-php-ext-enable redis

# New Relic
RUN \
  curl -L https://download.newrelic.com/php_agent/release/newrelic-php5-9.2.0.247-linux.tar.gz | tar -C /tmp -zx && \
   export NR_INSTALL_USE_CP_NOT_LN=1 && \
    export NR_INSTALL_SILENT=1 && \
     /tmp/newrelic-php5-*/newrelic-install install && \
      rm -rf /tmp/newrelic-php5-* /tmp/nrinstall*

# clean apt cache
RUN rm -rf /var/lib/apt/lists/*

CMD ["/usr/bin/supervisord", "-n", "-c", "/etc/supervisord.conf"]

EXPOSE 80
