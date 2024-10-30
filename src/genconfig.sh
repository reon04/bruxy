#!/bin/sh
SCRIPTPATH=/etc/nginx
short=${SHORT_DOMAIN:-rub.de}
long=${LONG_DOMAIN:-ruhr-uni-bochum.de}

shortr=$(echo "$short" | sed "s/\./\\\\\\\\./g")
longr=$(echo "$long" | sed "s/\./\\\\\\\\./g")

cp $SCRIPTPATH/nginx.conf.template $SCRIPTPATH/nginx.conf

sed -i -e "s/?replace_label_short_domain?/$short/g" $SCRIPTPATH/nginx.conf
sed -i -e "s/?replace_label_short_domain_regex?/$shortr/g" $SCRIPTPATH/nginx.conf
sed -i -e "s/?replace_label_long_domain?/$long/g" $SCRIPTPATH/nginx.conf
sed -i -e "s/?replace_label_long_domain_regex?/$longr/g" $SCRIPTPATH/nginx.conf

nginx -s reload