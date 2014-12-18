#!/bin/bash

echo "nameserver 202.120.2.101" > /etc/resolv.conf

DIR=/etc/mysql

sed -i 's/us.archive.ubuntu.com/ftp.sjtu.edu.cn/g' /etc/apt/sources.list

apt-get update
apt-get install python-mysqldb mysql-server -y

sed -i '/bind-address/c bind-address = controller' $DIR/my.cnf

sed -i '/\[mysqld\]/a\
default-storage-engine = innodb\
innodb_file_per_table\
collation-server = utf8_general_ci\
init-connect = '"'SET NAMES utf8'"'\
character-set-server = utf8' $DIR/my.cnf

service mysql restart

mysql_secure_installation

