FROM ubuntu:14.04
RUN apt-get update \
   && apt-get install -y autoconf libxml2-dev gcc libxml2 curl libcurl4-openssl-dev libbz2-dev libpng-dev make supervisor g++
ENV PHP_SRC http://cn2.php.net/get/php-5.6.17.tar.gz/from/this/mirror
WORKDIR /root
RUN curl -fSL $PHP_SRC -o php-src.tar.gz \
    && mkdir php-src \
    && tar zxvf php-src.tar.gz -C php-src --strip-components=1 \
    && cd php-src \
    && ./configure --prefix=/usr/local/php --with-config-file-scan-dir=/usr/local/php/conf.d --enable-bcmath --enable-calendar --enable-dba \
       --enable-mbstring --enable-shmop --enable-soap --enable-sockets --enable-sysvmsg --enable-zip --with-gd  \
     --with-xmlrpc --enable-zend-signals  --with-pdo-mysql --with-bz2  --with-zlib --with-openssl --enable-fpm \
     --with-fpm-user=www-data --with-fpm-group=www-data --with-curl \
    && make && make install \
    && cd .. \
    && cp /usr/local/php/etc/php-fpm.conf.default /usr/local/php/etc/php-fpm.conf \
    && cp /root/php-src/php.ini-production /usr/local/php/lib/php.ini \
    && rm -rf php-src \
    && rm -rf php-src.tar.gz
COPY run/entry.sh /root/entry.sh
RUN sh /root/entry.sh
COPY config/supervisord.conf /root/supervisord.conf
CMD /usr/bin/supervisord -c /root/supervisord.conf
