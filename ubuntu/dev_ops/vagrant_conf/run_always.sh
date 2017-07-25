#!/usr/bin/env bash

#-------Start/restart apache
echo "=====================Restarting apache and updating composer"
#sudo service apache2 restart
sudo /etc/init.d/apache2 restart
echo "----------Apache restarted"

