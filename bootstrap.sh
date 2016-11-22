#!/usr/bin/env bash

# Use single quotes instead of double quotes to make it work with special-character passwords
PASSWORD='1234'
PROJECTFOLDER='./'

# create project folder
sudo mkdir "/var/www/html/${PROJECTFOLDER}"

# update / upgrade
sudo apt-get update
sudo apt-get -y upgrade

# install apache 2.5 and php 7
sudo apt-get install -y apache2

sudo apt-get install software-properties-common
sudo add-apt-repository ppa:ondrej/php

sudo apt-get update &&
sudo apt-get install php7.0-fpm php7.0-cli php7.0-common php7.0-json php7.0-opcache php7.0-mysql php7.0-phpdbg php7.0-mbstring php7.0-gd php7.0-imap php7.0-ldap php7.0-pgsql php7.0-pspell php7.0-recode php7.0-snmp php7.0-tidy php7.0-dev php7.0-intl php7.0-gd php7.0-curl php7.0-zip php7.0-xml php7.0-curl php7.0-json php7.0-mcrypt

# install mysql and give password to installer
sudo debconf-set-selections <<< "mysql-server mysql-server/root_password password $PASSWORD"
sudo debconf-set-selections <<< "mysql-server mysql-server/root_password_again password $PASSWORD"
sudo apt-get -y install mysql-server

# install phpmyadmin and give password(s) to installer
# for simplicity I'm using the same password for mysql and phpmyadmin
sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/dbconfig-install boolean true"
sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/app-password-confirm password $PASSWORD"
sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/mysql/admin-pass password $PASSWORD"
sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/mysql/app-pass password $PASSWORD"
sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/reconfigure-webserver multiselect apache2"
sudo apt-get -y install phpmyadmin

# setup hosts file
VHOST=$(cat <<EOF
<VirtualHost *:80>
    DocumentRoot "/var/www/html/${PROJECTFOLDER}"
    ServerName http_stuff.dev
    <Directory "/var/www/html/${PROJECTFOLDER}">
        AllowOverride All
        Require all granted
    </Directory>
</VirtualHost>
EOF
)
echo "${VHOST}" > /etc/apache2/sites-available/000-default.conf

echo "${VHOST}" | sudo tee /etc/apache2/sites-available/http_stuff.dev

sudo a2ensite http_stuff.dev

# enable mod_rewrite
sudo a2enmod rewrite

# restart apache
service apache2 restart

# install git
sudo apt-get -y install git

# install xdebug
#sudo apt-get install php-xdebug

# install Composer
curl -s https://getcomposer.org/installer | php
mv composer.phar /usr/local/bin/composer