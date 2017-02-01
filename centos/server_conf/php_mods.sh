#!/usr/bin/env bash

	echo "================= START INSTALL-php_mods.SH $(date +"%r") ================="
	echo " "
	
	# Get and update reop
	sudo rpm -Uvh http://repo.webtatic.com/yum/el6/latest.rpm
	sudo yum -y update

	# Install php and modules (Source https://webtatic.com/packages/php70/ )
	sudo yum -y install php70w php70w-common php70w-mysql php70w-pdo php70w-opcache php70w-mcrypt php70w-xml php70w-devel php70w-pear php70w-mcrypt php70w-gd
    sudo yum -y install php70w-pecl-imagick
	sudo yum -y install httpd mod_ssl chkconfig memcached zlib zlib-devel gcc php-phpseclib-crypt-base php-phpseclib-crypt-rsa
	sudo yum -y install php-curl
	sudo yum -y install php70w-soap.x86_64
	sudo yum -y install php70w-mbstring.x86_64
	sudo yum -y install php70w-fpm.x86_64
	sudo yum -y install php70w-phpdbg.x86_64
	sudo yum -y install php70w-cli.x86_64

	# Dev environment php.ini
	## No need for .htaccess overrides
	## Change all setting here
	sudo cp /vagrant/server_conf/php.ini /etc/php.ini
	
	echo ""
	echo "================= End INSTALL-php_mods.SH $(date +"%r") ================="
