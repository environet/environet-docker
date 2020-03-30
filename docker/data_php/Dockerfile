FROM php:7.4

RUN apt-get update
RUN apt-get -y upgrade

#Install and enable xdebug
RUN pecl install xdebug
RUN docker-php-ext-enable xdebug
