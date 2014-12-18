#!/bin/bash

echo "nameserver 202.120.2.101" > /etc/resolv.conf

sed -i 's/us.archive.ubuntu.com/ftp.sjtu.edu.cn/g' /etc/apt/sources.list

apt-get update
apt-get install python-mysqldb -y
