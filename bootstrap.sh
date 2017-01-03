#!/usr/bin/env bash

# Use single quotes instead of double quotes to make it work with special-character passwords
# variables
DBNAME='development'
PASSWORD='1234'
PROJECTFOLDER='./'
PROJECTNAME='my_api'
DBUSER='root'


# update / upgrade
sudo apt-get update
sudo apt-get -y upgrade

# install apache 2.5 and php 7
sudo apt-get install -y apache2

sudo apt-get install software-properties-common
sudo add-apt-repository ppa:ondrej/php

sudo apt-get update

##########################################################
#				Install PHP
##########################################################
echo -e "\n--- Install PHP ---\n"
sudo apt-get install -y php7.0-fpm php7.0-common php7.0-opcache php7.0-phpdbg php7.0-mbstring php7.0-gd php7.0-imap php7.0-ldap php7.0-pgsql php7.0-pspell php7.0-recode php7.0-snmp php7.0-tidy php7.0-dev php7.0-intl php7.0-gd php7.0-curl php7.0-zip php7.0-xml php7.0-curl php7.0-json php7.0-mcrypt

sudo apt-get install -y php7.0-mysql

##########################################################
#				Install Xdebug
##########################################################
echo -e "\n--- Installing Xdebug ---\n"
sudo apt-get install -y php-xdebug
cat << EOF | sudo tee -a /etc/php/7.0/cli/conf.d/xdebug.ini
zend_extension="/usr/lib/php/20160303/xdebug.so"
xdebug.remote_enable=on
xdebug.remote_connect_back=on
EOF


##########################################################
#				Install MySQL
##########################################################
# install mysql and give password to installer
sudo debconf-set-selections <<< "mysql-server mysql-server/root_password password $PASSWORD"
sudo debconf-set-selections <<< "mysql-server mysql-server/root_password_again password $PASSWORD"
sudo apt-get -y install mysql-server mysql-client

# install phpmyadmin and give password(s) to installer
# for simplicity I'm using the same password for mysql and phpmyadmin
sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/dbconfig-install boolean true"
sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/app-password-confirm password $PASSWORD"
sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/mysql/admin-pass password $PASSWORD"
sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/mysql/app-pass password $PASSWORD"
sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/reconfigure-webserver multiselect apache2"
sudo apt-get -y install phpmyadmin

echo -e "\n--- Setting up our MySQL user and db ---\n"
mysql -uroot -p$DBPASSWD -e "CREATE DATABASE $DBNAME" >> /vagrant/vm_build.log 2>&1
mysql -uroot -p$DBPASSWD -e "grant all privileges on $DBNAME.* to '$DBUSER'@'localhost' identified by '$DBPASSWD'" > /vagrant/vm_build.log 2>&1


##########################################################
#				Apache Vhosts
##########################################################
# create project folder
sudo chmod -R 755 /var/www
sudo mkdir "/var/www/$PROJECTNAME"

# setup hosts file
VHOST=$(cat <<EOF
<VirtualHost *:80>
    ServerName $PROJECTNAME.dev
    DocumentRoot /var/www/$PROJECTNAME
    ErrorLog /var/www/$PROJECTNAME/apache.error.log
    CustomLog /var/www/$PROJECTNAME/apache.access.log common
    php_flag log_errors on
    php_flag display_errors on
    php_value error_reporting 2147483647
    php_value error_log /var/www/$PROJECTNAME/php.error.log
   <Directory "/var/www/$PROJECTNAME">
        AllowOverride All
        Require all granted
   </Directory>
</VirtualHost>
EOF
)
echo "${VHOST}" > /etc/apache2/sites-available/000-default.conf

sudo cp /etc/apache2/sites-available/000-default.conf /etc/apache2/sites-available/$PROJECTNAME.conf

echo "${VHOST}" | sudo tee /etc/apache2/sites-available/$PROJECTNAME.conf

sudo a2ensite $PROJECTNAME.conf

# enable mod_rewrite
sudo a2enmod rewrite

##########################################################
#				Install Extras
##########################################################
# install Composer
curl -s https://getcomposer.org/installer | php
mv composer.phar /usr/local/bin/composer

sudo apt-get install snmp

# restart apache
sudo apt-get -y install libapache2-mod-php7.0
sudo a2dismod php5
sudo a2enmod php7.0

service apache2 restart