#!/bin/bash

# VARIABLES
update="sudo pacman -Syyuu --noconfirm"
install="sudo pacman -S --noconfirm"
linenumber=`grep -rin 'LoadModule unique_id_module modules/mod_unique_id.so' httpd.conf | egrep '[0-9]'`
enable_soft="sudo systemctl enable"
start_soft="sudo systemctl start"
status_soft="sudo systemctl status"
restart_soft="sudo systemctl restart"
httpd_file="/etc/httpd/conf/httpd.conf"
change_line() {
    sed -i '"$1"s/.*/"$2"/' $httpd_file
}
take_line() {
    return `grep -rin $1 $httpd_file | grep '[0-9]'`
}

# UPDATE THE SYSTEM
$update

# INSTALL AND CONFIGURE APACHE
$install apache
apache_line=`take_line "LoadModule unique_id_module modules/mod_unique_id.so"`
change_line $apache_line "#LoadModule unique_id_module modules/mod_unique_id.so"


echo -e "<?php\n    phpinfo();\n?>" >> /srv/http/index.php

$enable_soft httpd
$start_soft httpd
$status_soft httpd

# INSTALL AND CONFIGURE MYSQL
$install mysql

sudo mysql_install_db --user=mysql --basedir=/usr --datadir=/var/lib/mysql

$enable_soft mysqld
$start_soft mysqld
$status_soft mysqld

sudo mysql_secure_installation

# INSTALL AND CONFIGURE PHP
$install php php-apache

php_apache_line=`take_line "LoadModule mpm_event_module modules/mod_mpm_event.so"`
change_line $apache_line "#LoadModule mpm_event_module modules/mod_mpm_event.so"
echo "LoadModule mpm_prefork_module modules/mod_mpm_prefork.so" >> $httpd_file
echo "LoadModule php_module modules/libphp.so" >> $httpd_file
echo "AddHandler php-script php" >> $httpd_file
echo "Include conf/extra/php_module.conf" >> $httpd_file

$restart_soft httpd

# INSTALL AND CONFIGURE PHPMYADMIN
$install phpmyadmin

phpmyadmin=`take_line "extension=bz2"`
change_line $phpmyadmin "extension=bz2"
phpmyadmin=`take_line "extension=mysqli"`
change_line $phpmyadmin "extension=mysqli"

echo -e "Alias /phpmyadmin '/usr/share/webapps/phpMyAdmin'\n<Directory '/usr/share/webapps/phpMyAdmin'>\nDirectoryIndex index.php\nAllowOverride All\nOptions FollowSymlinks\nRequire all granted\n</Directory>" >> /etc/httpd/conf/extra/phpmyadmin.conf
echo "Include conf/extra/phpmyadmin.conf" >> $httpd_file

$restart_soft httpd

# INSTALLING COMPOSER
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
php -r "if (hash_file('sha384', 'composer-setup.php') === '906a84df04cea2aa72f40b5f787e49f22d4c2f19492ac310e8cba5b96ac8b64115ac402c8cd292b8a03482574915d1a8') { echo 'Installer verified';  } else { echo 'Installer corrupt'; unlink('composer-setup.php');  } echo PHP_EOL;"
php composer-setup.php
php -r "unlink('composer-setup.php');"

