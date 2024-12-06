#!/bin/bash
SCRIPTPATH=/etc/nginx

# insert domain name to listen on
short=${SHORT_DOMAIN:-rub.de}
long=${LONG_DOMAIN:-ruhr-uni-bochum.de}
shortr=$(echo "$short" | sed "s/\./\\\\\\\\./g")
longr=$(echo "$long" | sed "s/\./\\\\\\\\./g")
shortr=$(echo "$shortr" | sed "s/:[0-9]*//g")
longr=$(echo "$longr" | sed "s/:[0-9]*//g")
sed -i -e "s/?replace_label_short_domain?/$short/g" $SCRIPTPATH/nginx.conf
sed -i -e "s/?replace_label_short_domain_regex?/$shortr/g" $SCRIPTPATH/nginx.conf
sed -i -e "s/?replace_label_long_domain?/$long/g" $SCRIPTPATH/nginx.conf
sed -i -e "s/?replace_label_long_domain_regex?/$longr/g" $SCRIPTPATH/nginx.conf

# insert string substitutions 
while IFS="" read -r p || [ -n "$p" ]
do
  sub="subs_filter \"$(echo "$p" | tr -d '\n' | sed -e "s/;/\" \"/g")\";"
  escaped_sub=$(printf '%s' "$sub" | sed -e 's/[\/&]/\\&/g')
  sed -i -e "s/?replace_label_subs?/$escaped_sub\n      ?replace_label_subs?/g" $SCRIPTPATH/nginx.conf
done < subs.txt

# insert regex string substitutions
while IFS="" read -r p || [ -n "$p" ]
do
  sub="subs_filter \"$(echo "$p" | tr -d '\n' | sed -e "s/;/\" \"/g")\" r;"
  escaped_sub=$(printf '%s' "$sub" | sed -e 's/[\/&]/\\&/g')
  sed -i -e "s/?replace_label_subs?/$escaped_sub\n      ?replace_label_subs?/g" $SCRIPTPATH/nginx.conf
done < subs_regex.txt
sed -i -e "s/?replace_label_subs?//g" $SCRIPTPATH/nginx.conf

# insert resources substitutions
while IFS="" read -r p || [ -n "$p" ]
do
  sub="location $(echo "$p" | tr -d '\n' | sed -e "s/;/ {?new_line_label?      alias \/usr\/share\/nginx\/html\//g");"
  escaped_sub=$(printf '%s' "$sub" | sed -e 's/[\/&]/\\&/g')
  escaped_sub=$(printf '%s' "$escaped_sub" | sed -e 's/?new_line_label?/\\n/g')
  sed -i -e "s/?replace_label_res_subs?/$escaped_sub\n      add_header Access-Control-Allow-Origin \"*\" always;\n    }\n    ?replace_label_res_subs?/g" $SCRIPTPATH/nginx.conf
done < res_subs.txt

# insert regex resources substitutions
while IFS="" read -r p || [ -n "$p" ]
do
  sub="location ~$(echo "$p" | tr -d '\n' | sed -e "s/;/ {?new_line_label?      alias \/usr\/share\/nginx\/html\//g");"
  escaped_sub=$(printf '%s' "$sub" | sed -e 's/[\/&]/\\&/g')
  escaped_sub=$(printf '%s' "$escaped_sub" | sed -e 's/?new_line_label?/\\n/g')
  sed -i -e "s/?replace_label_res_subs?/$escaped_sub\n      add_header Access-Control-Allow-Origin \"*\" always;\n    }\n    ?replace_label_res_subs?/g" $SCRIPTPATH/nginx.conf
done < res_subs_regex.txt
sed -i -e "s/?replace_label_res_subs?//g" $SCRIPTPATH/nginx.conf