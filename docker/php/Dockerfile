FROM php:7.4-fpm-buster

#Some overwrites of the php-fpm pool (which called zz-docker.conf
COPY zzz-docker.conf /usr/local/etc/php-fpm.d/
COPY environet.ini "$PHP_INI_DIR/conf.d/environet.ini"

RUN apt-get update
RUN apt-get -y upgrade

#Install some basic lpackages
RUN apt-get -y install nano wget gnupg lsb-release;

RUN wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -
RUN sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'

RUN apt-get update

#Install PG lib and postgres client
RUN apt-get -y install postgresql-client-12
RUN apt-get -y install libpq-dev

#Install and enable xdebug
RUN pecl install xdebug
RUN docker-php-ext-enable xdebug

#Install and enable pg and pdo librariesex
RUN docker-php-ext-install pdo pdo_pgsql pgsql
