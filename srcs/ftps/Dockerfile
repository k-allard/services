# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: kallard <kallard@student.21-school.ru>     +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/10/13 00:24:40 by kallard           #+#    #+#              #
#    Updated: 2020/10/27 02:37:57 by kallard          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM alpine:latest

LABEL maintainer="kallard@student.21-school.ru"

# Updates packages, installs vsftpd
RUN apk update && \
	apk add vsftpd && \
	apk add shadow && \
	apk add openssl

# Copy configuration files
WORKDIR /tmp
COPY . .

RUN mkdir -p /var/ftp && \
	mkdir -p /var/ftp/uploads && \
	chown ftp:ftp /var/ftp/uploads && \
	chmod 777 /var/ftp/uploads && \
	usermod --home /var/ftp ftp && \
	cp src_vsftpd.conf /var/ftp/vsftpd.conf && \
	chown nobody:nogroup /var/ftp && \
	cp src_vsftpd.conf /etc/vsftpd/vsftpd.conf && \
	openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
	-subj '/C=RU/ST=77/L=Moscow/O=School21/CN=localhost' \
	-keyout /etc/ssl/private/ftps.key -out /etc/ssl/certs/ftps.crt && \
	chmod +x startup.sh && \
	rm -f /tmp/src*

EXPOSE 20 21 40000

CMD ["/bin/sh", "/tmp/startup.sh"]
