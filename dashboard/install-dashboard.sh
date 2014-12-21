#!/bin/bash

echo "nameserver 202.120.2.101" > /etc/resolv.conf

apt-get install apache2 memcached libapache2-mod-wsgi openstack-dashboard -y

apt-get remove --purge openstack-dashboard-ubuntu-theme -y


