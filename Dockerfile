FROM ubuntu:24.04

RUN apt-get update && apt-get install -y \
    software-properties-common \
    --no-install-recommends \
	&& add-apt-repository ppa:ondrej/nginx \
  && apt-get update && apt-get install -y \
	  nginx \
	  libnginx-mod-http-subs-filter \
	  --no-install-recommends \
	&& apt-get autoremove --purge -y \
	  software-properties-common \
	&& rm -rf /var/lib/apt/lists/*

COPY src/res/* /usr/share/nginx/html

WORKDIR /etc/nginx
COPY src/nginx.conf.template src/startup.sh .
RUN chmod 744 nginx.conf.template startup.sh

# forward request and error logs to docker log collector
RUN ln -sf /dev/stdout /var/log/nginx/access.log \
	&& ln -sf /dev/stderr /var/log/nginx/error.log

EXPOSE 80

CMD ["/etc/nginx/startup.sh"]