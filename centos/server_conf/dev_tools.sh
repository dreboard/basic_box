#!/usr/bin/env bash

##########################################################
#				Install Extras
##########################################################
	# Install composer
    curl -sS https://getcomposer.org/installer | php
    # Move it to /usr/local/bin/
    sudo mv composer.phar /usr/local/bin/composer
