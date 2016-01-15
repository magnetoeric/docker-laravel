FROM ubuntu:14.04
RUN apt-get update \
   && apt-get install -y autoconf libxml2-dev gcc libxml2 curl libcurl4-openssl-dev libbz2-dev libpng-dev make supervisor g++

ADD setup/php-src /root/php-src
WORKDIR /root/php-src
RUN ./configure --prefix=/usr/local/php --with-config-file-scan-dir=/usr/local/php/conf.d --enable-bcmath --enable-calendar --enable-dba \
       --enable-mbstring --enable-shmop --enable-soap --enable-sockets --enable-sysvmsg --enable-zip --with-gd  \
     --with-xmlrpc --enable-zend-signals  --with-pdo-mysql --with-bz2  --with-zlib --with-openssl --enable-fpm \
     --with-fpm-user=www-data --with-fpm-group=www-data --with-curl \
    && make && make install 

ADD setup/pcre /root/pcre
WORKDIR /root/pcre
RUN ./configure \
    && make && make install

ADD setup/nginx /root/nginx
WORKDIR /root/nginx
RUN ./configure  --prefix=/usr/local/nginx  --conf-path=/usr/local/nginx/nginx.conf --with-http_ssl_module \
      --with-http_gzip_static_module  --sbin-path=/usr/sbin/nginx --with-pcre=/root/pcre --pid-path=/usr/local/nginx/logs/nginx.pid\
     && make \
     && make install

WORKDIR /root
RUN cp /usr/local/php/etc/php-fpm.conf.default /usr/local/php/etc/php-fpm.conf \
    && cp php.ini-production /usr/local/php/lib/php.ini

ADD config /root/config 
RUN mv /root/config/nginx.conf /usr/local/nginx/nginx.conf \
    && mv /root/config/servers /usr/local/nginx/servers

CMD /usr/bin/supervisord -c /root/config/supervisor.conf


