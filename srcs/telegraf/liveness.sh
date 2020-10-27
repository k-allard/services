#!/bin/sh
pgrep "telegraf"
return_telegraf=$?
if [ $return_telegraf = 0 ] ; then
	exit 0
else
	exit 1
fi
