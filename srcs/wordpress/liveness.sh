#!/bin/sh
pgrep "nginx"
return_nginx=$?
pgrep "php-fpm7"
return_fpm=$?
if [ $return_nginx = 0 ] && [ $return_fpm = 0 ]; then
	exit 0
else
	exit 1
fi
