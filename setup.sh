# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    setup.sh                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: kallard <kallard@student.21-school.ru>     +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/10/11 19:31:51 by kallard           #+#    #+#              #
#    Updated: 2020/10/27 16:13:00 by kallard          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#!/bin/bash

# setup.sh starts k8s cluster

# you need to have kubectl, virtualbox and minikube installed

# variables
SSH_USER=kallard
SSH_PASS=pass
MYSQL_USER=mysql
MYSQL_PASS=pass
INFLUX_USER=influx
INFLUX_PASS=pass
GRAFANA_USER=grafana
GRAFANA_PASS=pass

AUTOINDEX=on
WP_DB=wordpress

# removing existing cluster
minikube delete

# setting up minikube and starting cluster using Virtual Box
minikube start --driver=virtualbox
minikube addons enable dashboard
minikube addons enable metallb ; sleep 3 ; kubectl apply -f ./srcs/metallb/metallb.yaml
minikube addons enable metrics-server       # collects information about used resources. some dashboard features require it

# setting docker environment variables
eval $(minikube docker-env)                 # evaluate and put into effect a set of Bash env variable exports to configure your local environment to re-use the Docker daemon inside the Minikube instance
MINIKUBE_IP=$(minikube ip)                  # finding out the cluster's ip address

# creating secrets and configmaps
kubectl create secret generic ssh-secret --from-literal=user=$SSH_USER --from-literal=password="$SSH_PASS"
kubectl create secret generic mysql-secret --from-literal=user=$MYSQL_USER --from-literal=password="$MYSQL_PASS"
kubectl create secret generic influx-secret --from-literal=user=$INFLUX_USER --from-literal=password="$INFLUX_PASS"
kubectl create secret generic grafana-secret --from-literal=user=$GRAFANA_USER --from-literal=password="$GRAFANA_PASS"
kubectl create configmap nginx-autoindex --from-literal=autoindex=$AUTOINDEX
kubectl create configmap mysql-servaddr --from-literal=mysql-servaddr=$MYSQL_SERV
kubectl create configmap wordpress-dbname --from-literal=wordpress-dbname=$WP_DB
kubectl create configmap minikube-ip --from-literal=minikube-ip=$MINIKUBE_IP

# building nginx image and deploying to the cluster 
docker build --build-arg SSH_USER=$SSH_USER --build-arg SSH_PASS=$SSH_PASS \
	--build-arg AUTOINDEX=$AUTOINDEX -t services_nginx ./srcs/nginx ; \
	kubectl apply -f ./srcs/nginx/nginx.yaml

# building ftps image and deploying to the cluster
docker build -t services_ftps ./srcs/ftps ; \
	kubectl apply -f ./srcs/ftps/ftps.yaml

# building mysql image and deploying to the cluster
docker build --build-arg MYSQL_USER=$MYSQL_USER --build-arg MYSQL_PASS=$MYSQL_PASS \
	--build-arg WP_DB=$WP_DB -t services_mysql ./srcs/mysql ; \
	kubectl apply -f ./srcs/mysql/mysql.yaml

MYSQL_SERV=$(kubectl get services | awk '/mysql/ {print $3}')

# building phpmyadmin image and deploying to the cluster
docker build --build-arg MYSQL_USER=$MYSQL_USER --build-arg MYSQL_PASS=$MYSQL_PASS \
	--build-arg MYSQL_SERV=$MYSQL_SERV -t services_pma ./srcs/pma ; \
    kubectl apply -f ./srcs/pma/pma.yaml

# building wordpress image and deploying to the cluster
docker build --build-arg MYSQL_USER=$MYSQL_USER --build-arg MYSQL_PASS=$MYSQL_PASS \
	--build-arg MYSQL_SERV=$MYSQL_SERV --build-arg WP_DB=$WP_DB -t services_wordpress \
	./srcs/wordpress ; kubectl apply -f ./srcs/wordpress/wordpress.yaml \


# building influxdb image and deploying to the cluster
docker build -t services_influxdb ./srcs/influxdb ; \
	kubectl apply -f ./srcs/influxdb/influxdb.yaml

# building telegraf image and deploying to the cluster
docker build -t services_telegraf ./srcs/telegraf ; \
	kubectl apply -f ./srcs/telegraf/telegraf.yaml

# building grafana image and deploying to the cluster
docker build -t services_grafana ./srcs/grafana ; \
	kubectl apply -f ./srcs/grafana/grafana.yaml

# Start Dashboard
minikube dashboard
