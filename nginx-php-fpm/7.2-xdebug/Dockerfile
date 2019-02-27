FROM bpol/php-fpm:7.2-xdebug

MAINTAINER Konrad Podgórski <konrad.podgorski@gmail.com>

USER root

RUN apt-get install -y nginx
RUN apt-get install -y supervisor

ADD etc /etc/

RUN echo "memory_limit = 512M" >> /usr/local/etc/php/conf.d/memory_limit.ini
ADD etc/php/conf.d /usr/local/etc/php/conf.d/

# let php-fpm access env variables
RUN sed -i 's/;clear_env = no/clear_env = no/g' /usr/local/etc/php-fpm.d/www.conf

RUN rm /etc/nginx/sites-enabled/default
RUN ln -s /etc/nginx/sites-available/default.conf /etc/nginx/sites-enabled/default.conf

WORKDIR /var/www

RUN usermod -u 1000 -s /bin/bash www-data

CMD ["/usr/bin/supervisord", "-n", "-c", "/etc/supervisord.conf"]

EXPOSE 80
