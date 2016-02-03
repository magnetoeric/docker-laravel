#!/bin/bash
docker build --tag php-env:0.1 -f php.Dockerfile ./
docker build --tag mynginx:0.1 -f nginx.Dockerfile ./
