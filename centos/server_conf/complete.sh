#!/usr/bin/env bash

		#disable the firewall
	sudo service iptables stop
	sudo chkconfig iptables off
	
	sudo yum groupinstall "Development tools"
	sudo service httpd restart
