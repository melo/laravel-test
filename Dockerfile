FROM composer AS vendor

## This will install project deps into /app/vendor
COPY . /app
RUN cd /app && composer install


FROM php:8

RUN apt update                                                                  \
  && apt upgrade -y                                                             \
  && apt install -y --no-install-recommends                                     \
  git unzip p7zip npm libpq-dev vim npm                                         \
  && apt purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false   \
  && rm -fr /var/cache/apt/* /var/lib/apt/lists/*

RUN docker-php-ext-configure pgsql -with-pgsql=/usr/local/pgsql \
  && docker-php-ext-install pdo pdo_pgsql

## We copy all the application code, and then overlay the vendor stuff
COPY  . /app
COPY --from=vendor /app/vendor/ /app/vendor/

WORKDIR /app
CMD [ "/bin/bash" ]
