#!/bin/sh

mysql -u $MYSQL_USER -p'$MYSQL_PASS' -h $MYSQL_SERV < /usr/share/phpmyadmin/sql/create_tables.sql
