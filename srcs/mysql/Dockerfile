# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: kallard <kallard@student.21-school.ru>     +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/10/13 15:00:32 by kallard           #+#    #+#              #
#    Updated: 2020/10/13 15:00:33 by kallard          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM alpine:latest

# Arg declarations are needed to inject values during build pass
ARG MYSQL_USER
ARG MYSQL_PASS
ARG WP_DB

LABEL maintainer="kallard@student.21-school.ru"

# Updates packages, installs MySQL
RUN apk update && \
	apk add mysql && \
	apk add mysql-client && \
	apk add gettext

WORKDIR /tmp
COPY . .

# Prepare configuration scripts
RUN envsubst \$MYSQL_USER,\$MYSQL_PASS < src_my.cnf > my.cnf && \
	envsubst \$MYSQL_USER,\$MYSQL_PASS,\$WP_DB < src_allow_ext.sql > \
	allow_ext.sql && \
	envsubst \$MYSQL_USER < src_startup.sh > startup.sh && \
	chmod +x startup.sh

CMD ["/bin/sh", "/tmp/startup.sh"]