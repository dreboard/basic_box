#!/usr/bin/env bash

	# Apache setup and auto boot
	sudo cp /vagrant/server_conf/httpd.conf /etc/httpd/conf/httpd.conf
	sudo chkconfig httpd on
	sudo service httpd start






