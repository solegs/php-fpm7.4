################################
#                              #
#   Ubuntu - PHP 7.4 CLI+FPM   #
#                              #
################################

FROM ubuntu:xenial

MAINTAINER solegs <solegs@gmail.com>

LABEL Vendor="solegs"
LABEL Description="PHP-FPM v7.4"
LABEL Version="1.0.0"

ENV LYBERTEAM_TIME_ZONE Europe/Kiev

#RUN apt-get install -y python-software-properties

RUN apt-get update -yqq \
    && apt-get install -yqq \
	ca-certificates \
    git \
    gcc \
    make \
    wget \
    mc \
    curl \
    sendmail

RUN DEBIAN_FRONTEND=noninteractive apt-get -y dist-upgrade
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install python-software-properties
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install software-properties-common
RUN DEBIAN_FRONTEND=noninteractive LC_ALL=C.UTF-8 add-apt-repository ppa:ondrej/php

## Install php7.4 extension
RUN apt-get update -yqq \
    && apt-get install -yqq \
    php7.4-pgsql \
	php7.4-mysql \
	php7.4-opcache \
	php7.4-common \
	php7.4-mbstring \
	php7.4-soap \
	php7.4-cli \
	php7.4-intl \
	php7.4-json \
	php7.4-xsl \
	php7.4-imap \
	php7.4-ldap \
	php7.4-curl \
	php7.4-gd  \
	php7.4-dev \
    php7.4-fpm \
    php7.4-bcmath \
    && apt-get install pkg-config \
    && pecl install mongodb \
    && echo "extension=mongodb.so" > /etc/php/7.4/cli/conf.d/ext-mongodb.ini \
    && echo "extension=mongodb.so" > /etc/php/7.4/fpm/conf.d/ext-mongodb.ini \
    && apt-get install -y -q --no-install-recommends \
       ssmtp

# Install redis extensions
RUN pecl install -o -f redis \
&&  rm -rf /tmp/pear \
&&  docker-php-ext-enable redis

# Add default timezone
RUN echo $LYBERTEAM_TIME_ZONE > /etc/timezone
RUN echo "date.timezone=$LYBERTEAM_TIME_ZONE" > /etc/php/7.4/cli/conf.d/timezone.ini

## Install composer globally
RUN echo "Install composer globally"
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin/ --filename=composer

# Copy our config files for php7.4 fpm and php7.4 cli
COPY php-conf/php.ini /etc/php/7.4/cli/php.ini
COPY php-conf/php-fpm.ini /etc/php/7.4/fpm/php.ini
COPY php-conf/php-fpm.conf /etc/php/7.4/fpm/php-fpm.conf
COPY php-conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf

RUN usermod -aG www-data www-data
# Reconfigure system time
RUN  dpkg-reconfigure -f noninteractive tzdata

COPY start.sh /start.sh
RUN chmod +x /start.sh

CMD ["/start.sh"]

WORKDIR /var/www/solegs

EXPOSE 9000
