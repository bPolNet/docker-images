FROM bpol/nginx-php-fpm:7.2-legacy-xdebug

MAINTAINER Konrad Podgórski <konrad.podgorski@gmail.com>

# Add Tini
ENV TINI_VERSION v0.18.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /usr/bin/tini
RUN chmod +x /usr/bin/tini

# unlimited memory for CLI
RUN echo "memory_limit = -1" > /usr/local/etc/php/conf.d/memory_limit.ini

USER www-data

ENTRYPOINT ["/usr/bin/tini", "--", "php"]
CMD [""]
