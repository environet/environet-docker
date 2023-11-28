FROM php:7.4-fpm-buster

ARG XDEBUG_MODE

#Some overwrites of the php-fpm pool (which called zz-docker.conf
COPY zzz-docker.conf /usr/local/etc/php-fpm.d/

RUN apt-get update
RUN apt-get -y upgrade

#Install some basic lpackages
RUN apt-get -y install nano wget gnupg lsb-release;

RUN wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -
RUN sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'

RUN apt-get update

#Install PG lib and postgres client
RUN apt-get -y install postgresql-client-12
RUN apt-get -y install libpq-dev libssh2-1-dev libssh2-1

#Install pandoc for html generation from md
RUN apt-get -y install pandoc

#Install zip package
RUN apt-get -y install libzip-dev

#Install and enable xdebug
RUN pecl install xdebug-3.1.5
RUN pecl install ssh2
RUN docker-php-ext-enable xdebug ssh2

#Install and enable pg and pdo librariesex
RUN docker-php-ext-install pdo pdo_pgsql pgsql zip

COPY environet.ini "${PHP_INI_DIR}/conf.d/environet.ini"
RUN echo "xdebug.mode=${XDEBUG_MODE}" > ${PHP_INI_DIR}/conf.d/xdebug.ini
