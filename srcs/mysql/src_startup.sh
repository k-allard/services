#!/bin/sh

mysql_install_db --user=$MYSQL_USER --ldata=/var/lib/mysql
cp /tmp/my.cnf /etc/my.cnf
/usr/bin/mysqld --init_file=/tmp/allow_ext.sql
