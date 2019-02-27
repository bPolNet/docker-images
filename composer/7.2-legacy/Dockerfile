FROM composer:latest as composer
FROM bpol/nginx-php-fpm:7.2-legacy

MAINTAINER Konrad Podgórski <konrad.podgorski@gmail.com>

# Add Tini
ENV TINI_VERSION v0.18.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /usr/bin/tini
RUN chmod +x /usr/bin/tini

COPY --from=composer /usr/bin/composer /usr/bin/composer

# Register the COMPOSER_HOME environment variable
ENV COMPOSER_HOME /var/www/var/cache/.composer

# unlimited memory for CLI
RUN echo "memory_limit = -1" > /usr/local/etc/php/conf.d/memory_limit.ini

USER www-data

ENTRYPOINT ["/usr/bin/tini", "--", "composer",  "--ansi"]
CMD ["-"]
