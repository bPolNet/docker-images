FROM bpol/nginx-php-fpm:7.2

MAINTAINER Konrad Podgórski <konrad.podgorski@gmail.com>

# php7.2 libmcrypt
RUN apt-get install -y libmcrypt-dev && \
    pecl install mcrypt-1.0.1 && \
    docker-php-ext-enable mcrypt

# php7.2 calendar
RUN docker-php-ext-configure calendar && docker-php-ext-install calendar

# php7.2 INTL
RUN apt-get install libicu-dev -y \
    && docker-php-ext-install intl

# php7.2 SOAP
RUN apt-get install libxml2 libxml2-dev -y \
    && docker-php-ext-install soap

# PDF generation
RUN apt-get install libxrender1 -y

# text editors
RUN apt-get install vim nano -y

# needed by cloud print
RUN apt-get install procps -y
