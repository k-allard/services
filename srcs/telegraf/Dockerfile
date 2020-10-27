# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: kallard <kallard@student.21-school.ru>     +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/10/25 23:17:22 by kallard           #+#    #+#              #
#    Updated: 2020/10/25 23:17:24 by kallard          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM alpine:latest

LABEL maintainer="kallard@student.21-school.ru"

# Updates packages and install telegraf and tools
RUN apk update && apk add wget nano gettext && \
	apk add --no-cache telegraf \
	--repository=http://dl-cdn.alpinelinux.org/alpine/edge/testing

WORKDIR /tmp
COPY . .

RUN mkdir /etc/telegraf && \
	chmod +x startup.sh && \
	cp src_telegraf.conf /etc/telegraf/telegraf.conf && \
	chmod +x liveness.sh

EXPOSE 4999

CMD ["/bin/sh", "/tmp/startup.sh"]
