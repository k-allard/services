# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: kallard <kallard@student.21-school.ru>     +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/10/25 23:09:56 by kallard           #+#    #+#              #
#    Updated: 2020/10/26 21:48:38 by kallard          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM alpine:latest

# Arg declarations are needed to inject values during build pass
ARG MYSQL_USER
ARG MYSQL_PASS
ARG MYSQL_SERV

LABEL maintainer="kallard@student.21-school.ru"

# Updates packages, installs nginx, php packages and tools
RUN apk update && \
	apk add nginx nano wget gettext supervisor mysql-client && \
	apk add php7 php7-fpm php7-opcache php7-gd php7-mysqli php7-zlib php7-curl \
	php7-mbstring php7-json php7-session php7-zip

# Copy configuration files
WORKDIR /tmp
COPY . .

# Configure Nginx
RUN adduser -D -g 'www' www && \
	mkdir -p /run/nginx && \
	cp /tmp/src_nginx.conf /etc/nginx/nginx.conf && \
	cp /tmp/src_nginx_site.conf /etc/nginx/conf.d/default.conf && \
	cp /tmp/src_www.conf /etc/php7/php-fpm.d/www.conf

# Install phpMyAdmin
WORKDIR /usr/share
RUN wget --no-verbose https://files.phpmyadmin.net/phpMyAdmin/4.9.5/phpMyAdmin-4.9.5-english.tar.gz && \
	tar -xf phpMyAdmin-4.9.5-english.tar.gz && \
	rm -f phpMyAdmin-4.9.5-english.tar.gz && \
	mv phpMyAdmin-4.9.5-english phpmyadmin && \
	mkdir -p /var/lib/phpmyadmin/tmp && \
	chown -R www:www /var/lib/phpmyadmin/tmp

# Configure phpMyAdmin
WORKDIR /tmp
RUN envsubst \$MYSQL_USER,\$MYSQL_PASS,\$MYSQL_SERV < src_config.inc.php > config.inc.php && \
	cp /tmp/config.inc.php /usr/share/phpmyadmin && \
	envsubst \$MYSQL_USER,\$MYSQL_PASS,\$MYSQL_SERV < src_create_dbs.sh > create_dbs.sh && \
	chmod +x create_dbs.sh

# Configure Supervisord and liveness probe
RUN mkdir -p /var/log/supervisor && \
	rm -f /tmp/src* && \
	chmod +x liveness.sh
COPY src_supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Expose does not publish the ports, but makes it known which ports an app use.
EXPOSE 5000

# Run nginx and php-fpm services via supervisord
CMD ["/bin/sh", "-c", "/tmp/create_dbs.sh ; /usr/bin/supervisord -c /etc/supervisor/conf.d/supervisord.conf"]
