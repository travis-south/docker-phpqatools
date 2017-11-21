FROM composer:1
RUN docker-php-ext-install sockets
RUN composer global require travis-south/phpqatools:4.0.2 \
	behat/mink-extension \
	behat/mink-goutte-driver \
	behat/mink-selenium2-driver \
	behat/mink-zombie-driver \
	drupal/coder
RUN apk add --update nodejs
RUN /tmp/vendor/bin/phpcs --config-set installed_paths /tmp/vendor/endouble/symfony3-custom-coding-standard,/tmp/vendor/drupal/coder/coder_sniffer
RUN apk update \
    && apk add --no-cache libmcrypt libmcrypt-dev openssh-client icu-dev \
    libxml2-dev freetype-dev libpng-dev libjpeg-turbo-dev g++ make autoconf \
    && pecl install xdebug \
    && echo "zend_extension=$(find /usr/local/lib/php/extensions/ -name xdebug.so)" > /usr/local/etc/php/conf.d/xdebug.ini \
    && echo "xdebug.remote_enable=on" >> /usr/local/etc/php/conf.d/xdebug.ini \
    && echo "xdebug.remote_autostart=off" >> /usr/local/etc/php/conf.d/xdebug.ini && php -m
ENV PATH="/tmp/vendor/bin:${PATH}"
VOLUME ["/app"]
WORKDIR /app
ENTRYPOINT []
