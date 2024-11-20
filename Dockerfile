FROM php:8

## Composer setup
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"                                                                                                                                                                                                     \
  && php -r "if (hash_file('sha384', 'composer-setup.php') === 'dac665fdc30fdd8ec78b38b9800061b4150413ff2e3b6f88543c636f7cd84f6db9189d43a81e5503cda447da73c7e5b6') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" \
  && php composer-setup.php                                                                                                                                                                                                                                                       \
  && php -r "unlink('composer-setup.php');"                                                                                                                                                                                                                                       \
  && mv composer.phar /usr/bin/composer                                                                                                                                                                                                                                           \
  && chmod 755 /usr/bin/composer

RUN apt update                                                                  \
  && apt upgrade -y                                                             \
  && apt install -y --no-install-recommends                                     \
  git unzip p7zip npm libpq-dev vim npm                                         \
  && apt purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false   \
  && rm -fr /var/cache/apt/* /var/lib/apt/lists/*

RUN docker-php-ext-configure pgsql -with-pgsql=/usr/local/pgsql \
  && docker-php-ext-install pdo pdo_pgsql

RUN composer global require laravel/installer
ENV PATH=/root/.composer/vendor/bin:$PATH

CMD [ "/bin/bash" ]
