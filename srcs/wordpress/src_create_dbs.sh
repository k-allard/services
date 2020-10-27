#!/bin/sh

mysql -u $MYSQL_USER -p'$MYSQL_PASS' -h $MYSQL_SERV < /tmp/wordpress_dbs.sql
