# Basic Vagrant Box Setup [![Build Status](https://travis-ci.org/dreboard/basic_box.svg?branch=master)](https://travis-ci.org/dreboard/basic_box)

Basic vagrant boxes in Ubuntu and Centos:

- ubuntu/xenial64
- [Apache]
- PHP[7.1]
- Phpmyadmin
- Composer

## Requirements
- [VirtualBox](http://www.virtualbox.org/wiki/Downloads)
- [Vagrant](http://www.vagrantup.com/downloads)

## PHP Modules

php7.1 php7.1-opcache php7.1-phpdbg php7.1-mbstring php7.1-cli php7.1-imap php7.1-ldap php7.1-pgsql php7.1-pspell php7.1-recode php7.1-snmp php7.1-tidy php7.1-dev php7.1-intl php7.1-gd php7.1-zip php7.1-xml php7.1-curl php7.1-json php7.1-mcrypt
php7.1-intl php7.1-xsl php7.1-mysql

### Laravel users (Ubuntu)
If you are having issues with migrating follow the steps below
 
To know the address which MySQL is bound to do the following:
- cat /etc/mysql/my.cnf | grep bind-address (Use this host)
- cd /var/www/site_name (Your site name)
- php artisan migrate