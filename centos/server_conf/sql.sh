#!/usr/bin/env bash

	echo "================= START INSTALL-MYSQL.SH $(date +"%r") ================="
	echo " "	
	
	# phpmyadmin installation
	sudo yum -y install phpmyadmin


	echo "BEGIN Database server setup ..."
	# Basic admin setup with default user
	#-u = root, -p ''
	sudo yum install mysql-server
	sudo service mysqld start

	# MySQL service to start up anytime the system enters runlevels 2,3 or 5
	chkconfig –level 235 mysqld on

	echo " "
	echo "================= END INSTALL-MYSQL.SH $(date +"%r") ================="