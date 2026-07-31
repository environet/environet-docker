FROM php:8.4-fpm-bookworm

ARG XDEBUG_MODE

RUN apt-get update
RUN apt-get -y upgrade


RUN apt-get install -y libzip-dev libssh2-1-dev libssh2-1 ssh
RUN docker-php-ext-install zip
RUN docker-php-ext-configure ftp --with-ftp-ssl
RUN docker-php-ext-install ftp

#Install and enable xdebug
RUN pecl install xdebug
RUN pecl install ssh2
RUN docker-php-ext-enable xdebug zip ssh2

RUN echo "xdebug.mode=${XDEBUG_MODE}" > ${PHP_INI_DIR}/conf.d/xdebug.ini
