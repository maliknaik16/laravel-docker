FROM php:7.3-fpm-alpine

RUN apk update

RUN set -ex \
    && apk --no-cache add postgresql-libs postgresql-dev \
    && docker-php-ext-install pgsql pdo pdo_pgsql \
    && apk del postgresql-dev

# MySQL Extension
# RUN docker-php-ext-install pdo pdo_mysql
