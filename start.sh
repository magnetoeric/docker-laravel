#!/bin/bash
. env
docker run -id -v $LARAVEL_DIR:/data -p 8080:80 -t php-env
