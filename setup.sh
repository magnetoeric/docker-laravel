#!/bin/bash
. env
rm -rf setup/*
cd setup


wget $PHP_SRC -O php-src.tar.gz
mkdir php-src
tar zxvf php-src.tar.gz -C php-src --strip-components=1

wget $PCRE_SRC -O pcre.tar.gz
mkdir pcre
tar zxvf pcre.tar.gz --strip-components=1
wget $NGINX_SRC -O nginx.tar.gz
mkdir nginx
tar zxvf nginx.tar.gz -C nginx --strip-components=1