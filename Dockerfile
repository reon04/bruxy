FROM debian:bookworm-slim

RUN apt-get update && apt-get install -y \
	ca-certificates \
	lua-cjson \
	lua-iconv \
	nginx-extras \
	--no-install-recommends \
	&& rm -rf /var/lib/apt/lists/*

COPY src/logo.svg /usr/share/nginx/html
COPY src/favicon.ico /usr/share/nginx/html

WORKDIR /etc/nginx
COPY src/nginx.conf.template .
COPY src/startup.sh .
RUN chmod 744 startup.sh nginx.conf.template

# forward request and error logs to docker log collector
RUN ln -sf /dev/stdout /var/log/nginx/access.log \
	&& ln -sf /dev/stderr /var/log/nginx/error.log

EXPOSE 80

CMD ["/etc/nginx/startup.sh"]