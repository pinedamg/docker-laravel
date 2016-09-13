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

#NODEJS INSTALL BOWER GULP
RUN npm install --global gulp
RUN npm install --global bower
RUN export DISABLE_NOTIFIER=true

#ADD LARAVEL RECOMMEND SETTINGS
COPY zz-laravel.ini /etc/php5/cli/conf.d/zz-laravel.ini
COPY zz-laravel.ini /etc/php5/apache/conf.d/zz-laravel.ini

#ADD LARAVEL ALIASES
COPY ./aliases /root/aliases
RUN cat /root/aliases >> /root/.bash_aliases && rm -f /root/aliases

#ADD VIRTUALHOST
COPY vhost.conf /etc/apache2/sites-enabled/000-default.conf
COPY vhost.conf /etc/apache2/sites-available/000-default.conf

RUN apt-get update && apt-get -y autoremove && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

WORKDIR /var/www