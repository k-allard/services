# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: kallard <kallard@student.21-school.ru>     +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/10/25 23:55:43 by kallard           #+#    #+#              #
#    Updated: 2020/10/26 22:00:06 by kallard          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM alpine:latest

# Arg declarations are needed to inject values during build pass
ARG MYSQL_USER
ARG MYSQL_PASS
ARG MYSQL_SERV
ARG WP_DB

LABEL maintainer="kallard@student.21-school.ru"

# Updates packages, installs nginx, php packages and tools
RUN apk update && \
	apk add nginx nano wget gettext supervisor mysql-client && \
	apk add php7 php7-fpm php7-opcache php7-gd php7-mysqli php7-zlib php7-curl \
	php7-mbstring php7-json php7-session php7-zip php7-gd

# Copy configuration files
WORKDIR /tmp
COPY . .

# Configure Nginx
RUN adduser -D -g 'www' www && \
	mkdir -p /run/nginx && \
	cp /tmp/src_nginx.conf /etc/nginx/nginx.conf && \
	cp /tmp/src_nginx_site.conf /etc/nginx/conf.d/default.conf && \
	cp /tmp/src_www.conf /etc/php7/php-fpm.d/www.conf

# Install wordpress
WORKDIR /var/www/localhost/htdocs
RUN wget --no-verbose https://wordpress.org/latest.tar.gz && \
	tar -xf latest.tar.gz && rm -f latest.tar.gz

# Configure wordpress
RUN chown -R www:www wordpress && \
	chmod 755 -R wordpress && \
	chmod g+s wordpress && \
	envsubst \$MYSQL_USER,\$MYSQL_PASS,\$MYSQL_SERV,\$WP_DB < /tmp/src_wp-config.php > \
		wordpress/wp-config.php && \
	envsubst \$MYSQL_USER,\$MYSQL_PASS,\$MYSQL_SERV < /tmp/src_create_dbs.sh > \
		/tmp/create_dbs.sh && \
	chmod +x /tmp/create_dbs.sh && \
	cp /tmp/load-styles.php wordpress/wp-admin

# Supervisord and liveness
RUN mkdir -p /var/log/supervisor && \
	rm -f /tmp/src* && \
	chmod +x /tmp/liveness.sh
COPY src_supervisord.conf /etc/supervisor/conf.d/supervisord.conf

EXPOSE 5050

# Run nginx and php-fpm services via supervisord
CMD ["/bin/sh", "-c", "/tmp/create_dbs.sh ; /usr/bin/supervisord -c /etc/supervisor/conf.d/supervisord.conf"]
