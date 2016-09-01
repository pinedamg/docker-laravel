FROM pinedamg/apache-php
MAINTAINER MPineda <pinedamg@gmail.com>

ENV DEBIAN_FRONTEND noninteractive

#INSTALL COMPOSER
RUN /usr/bin/curl -sS https://getcomposer.org/installer |/usr/bin/php
RUN /bin/mv composer.phar /usr/local/bin/composer

#INSTALL NODE AND EXTENSIONS
RUN apt-get update
RUN apt-get -y install nodejs npm
RUN ln -s /usr/bin/nodejs /usr/bin/node

RUN apt-get update && apt-get -y autoremove && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

WORKDIR /var/www