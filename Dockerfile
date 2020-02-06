FROM php:7.3-apache

RUN apt-get update && apt-get install -y \
      libicu-dev \
      libpq-dev \
    && rm -r /var/lib/apt/lists/* \
    && docker-php-ext-configure pgsql -with-pgsql=/usr/local/pgsql \
    && docker-php-ext-install \
       intl \
       mbstring \
       pcntl \
       pdo_mysql \
       pdo_pgsql \
       pgsql \
       opcache


# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin/ --filename=composer

ENV LARAVEL_HOME /var/www/html

RUN usermod -u 1000 www-data && groupmod -g 1000 www-data

RUN sed -i -e "s/html/html\/public/g" /etc/apache2/sites-enabled/000-default.conf

RUN a2enmod rewrite

RUN chown -R www-data:www-data $LARAVEL_HOME