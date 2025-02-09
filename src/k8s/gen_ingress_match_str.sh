#!/bin/bash
echo "generating k8s ingress.yml match string..."

# generate k8s ingress.yml match string
short=${SHORT_DOMAIN:-rub.de}
long=${LONG_DOMAIN:-ruhr-uni-bochum.de}
str="Host(\`${short}\`) || Host(\`${long}\`)"
while IFS="" read -r p || [ -n "$p" ]
do
  str="${str} || Host(\`${p}.${short}\`) || Host(\`${p}.${long}\`)"
done < subdomains.txt
echo $str