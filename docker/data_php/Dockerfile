FROM php:7.4

RUN apt-get update
RUN apt-get -y upgrade

#Install and enable xdebug
RUN pecl install xdebug
RUN docker-php-ext-enable xdebug

#install php zip extension
RUN apt-get install -y zlib1g-dev
RUN apt-get install -y libzip-dev
RUN docker-php-ext-install zip
