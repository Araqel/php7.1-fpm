FROM php:7.1-fpm
WORKDIR /var/www/html
ENV XDEBUGINI_PATH=/usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
RUN apt-get update \
  && apt-get install -y libssl-dev pkg-config \
  && apt-get install -y zlib1g-dev libicu-dev g++ \
  && apt-get install -y libcurl4-openssl-dev \
  && apt-get install -y --no-install-recommends apt-utils \
  && apt-get install -y libmcrypt-dev mysql-client \
  && apt-get -qq install curl -y \
  && apt-get install libzip-dev -y \
  && apt-get install zip unzip -y
RUN docker-php-ext-configure intl
RUN docker-php-ext-install intl
RUN apt-get update \
  && docker-php-ext-install mbstring mcrypt pdo_mysql curl opcache \
  && pecl install xdebug \
  && docker-php-ext-enable xdebug \
  && pecl install redis \
  && docker-php-ext-enable redis \
  && pecl install mongodb \
  && docker-php-ext-enable mongodb\
  && pecl install mailparse \
  && docker-php-ext-install zip
