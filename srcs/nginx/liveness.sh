#!/bin/sh
pgrep "nginx"
return_nginx=$?
pgrep "sshd"
return_sshd=$?
if [ $return_nginx = 0 ] && [ $return_sshd = 0 ]; then
	exit 0
else
	exit 1
fi
