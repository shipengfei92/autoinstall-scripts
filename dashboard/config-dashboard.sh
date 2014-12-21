#!/bin/bash


sed -i "/TIME_ZONE =/c TIME_ZONE = \'Asia/Shanghai\'  " /etc/openstack-dashboard/local_settings.py

#sed -i "/'LOCATION' :/c  'LOCATION' : 'controller:11211', " /etc/openstack-dashboard/local_settings.py

#sed -i "/-l /c -l controller " /etc/memcached.conf

sed -i "/OPENSTACK_HOST =/c OPENSTACK_HOST = \"controller\" " /etc/openstack-dashboard/local_settings.py


