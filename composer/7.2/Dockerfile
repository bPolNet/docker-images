FROM composer:latest as composer
FROM bpol/php-cli:7.2

MAINTAINER Konrad Podgórski <konrad.podgorski@gmail.com>

COPY --from=composer /usr/bin/composer /usr/bin/composer

# Register the COMPOSER_HOME environment variable
ENV COMPOSER_HOME /var/www/var/cache/.composer

# Disable XDEBUG for composer
USER root
RUN rm /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
USER www-data

ENTRYPOINT ["/usr/bin/tini", "--", "composer",  "--ansi"]
CMD ["-"]
