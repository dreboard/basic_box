#!/usr/bin/env bash

	echo "================= Start INSTALL-complete.SH $(date +"%r") ================="
	echo ""
	
	sudo cp /vagrant/server_conf/httpd.conf /etc/httpd/conf/httpd.conf
	sudo chkconfig httpd on
	sudo service httpd start
		#disable the firewall
	sudo service iptables stop
	sudo chkconfig iptables off
	
	sudo yum groupinstall "Development tools"
	sudo service httpd restart

	echo ""
	echo "================= End INSTALL-complete.SH $(date +"%r") ================="