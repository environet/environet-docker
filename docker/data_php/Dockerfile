FROM php:7.4

ARG XDEBUG_MODE

RUN apt-get update
RUN apt-get -y upgrade

RUN apt-get install -y libzip-dev
RUN docker-php-ext-install zip

#Install and enable xdebug
RUN pecl install xdebug
RUN docker-php-ext-enable xdebug zip

RUN echo "xdebug.mode=${XDEBUG_MODE}" > ${PHP_INI_DIR}/conf.d/xdebug.ini
