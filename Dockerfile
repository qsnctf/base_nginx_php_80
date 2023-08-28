FROM php:8.0-fpm-alpine

LABEL Organization="qsnctf" Author="M0x1n <lqn@sierting.com>"

COPY files /tmp/

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.nju.edu.cn/g' /etc/apk/repositories \
    && apk add --update --no-cache nginx \
    # configure file
    && mv /tmp/flag.sh /flag.sh \
    && mv /tmp/docker-entrypoint /usr/local/bin/docker-entrypoint \
    && mv /tmp/nginx.conf /etc/nginx/nginx.conf \
    && chown -R www-data:www-data /var/www/html \
    && chmod +x /usr/local/bin/docker-entrypoint \
    # clear
    && rm -rf /tmp/*
    # && rm -rf /etc/apk

WORKDIR /var/www/html

COPY www /var/www/html/

EXPOSE 80

VOLUME ["/var/log/nginx"]

CMD ["/bin/sh", "-c", "docker-entrypoint"]