# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: kallard <kallard@student.21-school.ru>     +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/10/13 00:30:33 by kallard           #+#    #+#              #
#    Updated: 2020/10/26 21:48:12 by kallard          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM alpine:latest

LABEL maintainer="kallard@student.21-school.ru"

# Install grafana and tools
RUN apk update && \
    apk add bash curl wget && \
    apk add grafana --repository http://dl-cdn.alpinelinux.org/alpine/edge/testing/

COPY . /tmp

WORKDIR /usr/share/grafana

# Configure grafana
RUN mkdir -p ./conf/provisioning/dashboards/my && \
	cp /tmp/datasources.yaml ./conf/provisioning/datasources && \
	cp /tmp/dashboards.yaml ./conf/provisioning/dashboards && \
	cp /tmp/dashboards/* ./conf/provisioning/dashboards/my

EXPOSE 3000

CMD ["/usr/sbin/grafana-server", "web"]
