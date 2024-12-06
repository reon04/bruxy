#!/bin/bash
SCRIPTPATH=/etc/nginx
cp $SCRIPTPATH/nginx.conf.template $SCRIPTPATH/nginx.conf

./replace.sh

nginx -g 'daemon off;'