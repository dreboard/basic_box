#!/usr/bin/env bash

	echo "================= START INSTALL-dev_tools.SH $(date +"%r") ================="
	echo " "

	sudo yum -y install nano
	# Install composer
	curl -sS https://getcomposer.org/installer | php
	# Move it to /usr/local/bin/
	sudo mv composer.phar /usr/local/bin/composer

	echo ""
	echo "================= End INSTALL-dev_tools.SH $(date +"%r") ================="
