# nginx 1.6 Mike Test

FROM hub.docker.91syt.com/centos:7.1
MAINTAINER Mike Huang <hhy5861@gmail.com>

RUN yum clean all && yum -y swap fakesystemd systemd && \
    yum -y install nginx php-fpm php-common && yum clean all

ADD supervisor_nginx.conf /etc/supervisord.d/nginx.conf
ADD nginx_default.conf /etc/nginx/conf.d/default.conf
ADD _nginx.conf  /etc/nginx/nginx.conf

RUN mkdir -p /data/web && mkdir -p /var/log/nginx && \
    chmod -R 777 /var/log/nginx && \
    echo "<?php phpinfo(); ?>" > /data/web/index.php

VOLUME ["/var/log/nginx"]
EXPOSE	80 443

ENTRYPOINT ["/usr/bin/supervisord", "-n", "-c", "/etc/supervisord.conf"]
