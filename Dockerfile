FROM composer:1
RUN docker-php-ext-install sockets
RUN composer global require travis-south/phpqatools:3.0.5 \
	&& composer global require behat/mink-extension \
	&& composer global require behat/mink-goutte-driver \
	&& composer global require behat/mink-selenium2-driver \
	&& composer global require behat/mink-zombie-driver \
	&& composer global require endouble/symfony3-custom-coding-standard \
	&& composer global require drupal/coder
RUN apt-get update && apt-get install nodejs -y
RUN /composer/vendor/bin/phpcs --config-set installed_paths /composer/vendor/endouble/symfony3-custom-coding-standard,/composer/vendor/drupal/coder/coder_sniffer
RUN yes | pecl install xdebug \
    && echo "zend_extension=$(find /usr/local/lib/php/extensions/ -name xdebug.so)" > /usr/local/etc/php/conf.d/xdebug.ini \
    && echo "xdebug.remote_enable=on" >> /usr/local/etc/php/conf.d/xdebug.ini \
    && echo "xdebug.remote_autostart=off" >> /usr/local/etc/php/conf.d/xdebug.ini && php -m
COPY entrypoint.sh /entrypoint.sh
RUN chmod 777 /*.sh
VOLUME ["/app"]
WORKDIR /app
ENTRYPOINT ["/entrypoint.sh"]
