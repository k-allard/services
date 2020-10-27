# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: kallard <kallard@student.21-school.ru>     +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/10/25 20:35:34 by kallard           #+#    #+#              #
#    Updated: 2020/10/26 01:29:03 by kallard          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM alpine:latest

# Arg declarations are needed to inject values during build pass
ARG SSH_USER
ARG SSH_PASS
ARG AUTOINDEX

LABEL maintainer="kallard@student.21-school.ru"

# Updates packages, installs nginx and tools
RUN apk update && \
	apk add nginx && \
	apk add wget && \
	apk add nano && \
	apk add openssl && \
	apk add openssh && \
	apk add gettext && \
	apk add supervisor

# Copy configuration files
WORKDIR /tmp
COPY . .

# Configure Nginx
# (virtual server configuration is applied)
RUN mkdir -p /run/nginx && \
	mkdir -p /etc/nginx/snippets && \
	mkdir -p /var/www/localhost/htdocs/images/branding/mountains && \
	envsubst \$AUTOINDEX < src_nginx_site.conf > site.conf && \
	cp /tmp/site.conf /etc/nginx/conf.d/default.conf && \
	cp /tmp/src_ssl_params.conf /etc/nginx/snippets/ssl_params.conf && \
	cp /tmp/src_self_signed.conf /etc/nginx/snippets/self_signed.conf && \
	cp /tmp/src_homepage.html /var/www/localhost/htdocs/index.html && \
	cp /tmp/mountains.jpg /var/www/localhost/htdocs/images/branding/mountains/mountains.jpg && \
	openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
	-subj '/C=RU/ST=77/L=Moscow/O=School21/CN=localhost' \
	-keyout /etc/ssl/private/localhost.key -out /etc/ssl/certs/localhost.crt

# Configure SSH
RUN sed -i s/#PermitRootLogin.*/PermitRootLogin\ yes/ /etc/ssh/sshd_config && \
	sed -i s/#PasswordAuthentication.*/PasswordAuthentication\ yes/ /etc/ssh/sshd_config && \
	sed -ie 's/#Port 22/Port 22/g' /etc/ssh/sshd_config && \
	adduser -D ${SSH_USER} && \
	echo "${SSH_USER}:${SSH_PASS}" | chpasswd && \
	echo "user = ${SSH_USER} pass = ${SSH_PASS}" && \
	ssh-keygen -A

# Configure Supervisord and liveness probe
RUN mkdir -p /var/log/supervisor && \
	rm -f /tmp/src_* && \
	chmod +x liveness.sh
COPY src_supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Expose does not publish the ports, but makes it known which ports an app use.
EXPOSE 22 80 443

# Run nginx and SSH services via supervisord
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]
