#!/bin/bash
isExistApp="pgrep nginx"
if [[ -n $isExistApp ]]; then
systemctl stop nginx.service
fi
isExistApp="pgrep mysqld"
if [[ -n $isExistApp ]]; then
systemctl stop mysql.service
fi
isExistApp="pgrep php-fpm"
if [[ -n $isExistApp ]]; then
systemctl stop php8.3-fpm.service
fi
