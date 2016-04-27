#!/bin/bash
. ./env

docker stop php-env
docker rm php-env
docker run -itd -v $LARAVEL_DIR:/data/app --name php-env    php-env:0.1

docker stop mynginx
docker rm mynginx
docker run -itd --link php-env:php-env --volumes-from php-env  -p 80:80 --name mynginx  mynginx:0.1
