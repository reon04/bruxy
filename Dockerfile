FROM nginx

RUN apt-get update && apt-get install -y nginx-extras

COPY src/logo.svg /usr/share/nginx/html
COPY src/favicon.ico /usr/share/nginx/html

WORKDIR /etc/nginx
COPY src/nginx.conf.template .
COPY src/genconfig.sh .
RUN chmod 744 genconfig.sh nginx.conf.template

RUN genconfig.sh
USER undefined