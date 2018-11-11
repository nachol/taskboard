FROM php:7.2-fpm
RUN DEBIAN_FRONTEND=noninteractive apt-get update \
	&& DEBIAN_FRONTEND=noninteractive apt-get install -y \
	sqlite3 \
	sqlite \
	git \
	git-core \
	curl \
	zip \
	unzip \
	nano \
	apache2 \
	libfreetype6-dev \
    libjpeg62-turbo-dev \
    libpng-dev \
    && docker-php-ext-install -j$(nproc) iconv \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd \
    && rm -rf /var/www/html/* \
	&& a2enmod rewrite \
	&& echo "ServerName localhost" >> /etc/apache2/apache2.conf \
	&& git clone https://github.com/kiswa/TaskBoard.git /var/www/html/

ADD ./vhost.conf /etc/apache2/sites-available/000-default.conf

ADD run.sh /run.sh
RUN chmod 0755 /run.sh

EXPOSE 80
CMD ["/run.sh"]