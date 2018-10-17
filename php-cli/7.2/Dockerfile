FROM php:7.2-cli

MAINTAINER Konrad Podgórski <konrad.podgorski@gmail.com>

# Add Tini
ENV TINI_VERSION v0.18.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /usr/bin/tini
RUN chmod +x /usr/bin/tini

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

RUN pecl install xdebug \
    && docker-php-ext-enable xdebug \
    && echo "xdebug.idekey=PHPSTORM" >> /usr/local/etc/php/conf.d/xdebug.ini \
    && echo "xdebug.default_enable=1" >> /usr/local/etc/php/conf.d/xdebug.ini \
    && echo "xdebug.remote_enable=1" >> /usr/local/etc/php/conf.d/xdebug.ini \
    && echo "xdebug.remote_autostart=1" >> /usr/local/etc/php/conf.d/xdebug.ini \
    && echo "xdebug.remote_connect_back=0" >> /usr/local/etc/php/conf.d/xdebug.ini \
    && echo "xdebug.remote_handler='dbgp'" >> /usr/local/etc/php/conf.d/xdebug.ini \
    && echo "xdebug.remote_mode=req" >> /usr/local/etc/php/conf.d/xdebug.ini \
    && echo "xdebug.profiler_enable=0" >> /usr/local/etc/php/conf.d/xdebug.ini \
    && echo "xdebug.remote_host=host.docker.internal" >> /usr/local/etc/php/conf.d/xdebug.ini \
    && echo "xdebug.remote_port=9001" >> /usr/local/etc/php/conf.d/xdebug.ini

# unlimited memory for CLI
RUN echo "memory_limit = -1" >> /usr/local/etc/php/conf.d/memory_limit.ini

WORKDIR /var/www

RUN usermod -u 1000 -s /bin/bash www-data

USER www-data

ENTRYPOINT ["/usr/bin/tini", "--", "php"]
CMD []
