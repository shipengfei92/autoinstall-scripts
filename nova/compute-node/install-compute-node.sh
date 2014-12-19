#!/bin/bash

source password-environment.sh

MY_IP=$1
MY_NAME=$2

sed -i '/127.0.0.1/a 192.168.0.107	controller' /etc/hosts
sed -i "/127.0.0.1/a $MY_IP	$MY_NAME" /etc/hosts

echo "nameserver 202.120.2.101" > /etc/resolv.conf

sed -i 's/archive.ubuntu.com/ftp.sjtu.edu.cn/g' /etc/apt/sources.list

apt-get update

apt-get install nova-compute-kvm -y

sed -i '/\[DEFAULT\]/a auth_strategy = keystone\
\
rpc_backend = rabbit\
rabbit_host = controller\
rabbit_password = '$RABBIT_PASS'\
\
my_ip = '$MY_IP'\
vnc_enabled = True\
vncserver_listen = 0.0.0.0\
vncserver_proxyclient_address = '$MY_IP'\
novncproxy_base_url = http://controller:6080/vnc_auto.html\
\
glance_host = controller\
\
' /etc/nova/nova.conf

echo "

[database]
# The SQLAlchemy connection string used to connect to the database
connection = mysql://nova:$NOVA_DBPASS@controller/nova

[keystone_authtoken]
auth_uri = http://controller:5000
auth_host = controller
auth_port = 35357
auth_protocol = http
admin_tenant_name = service
admin_user = nova
admin_password = $NOVA_PASS" >> /etc/nova/nova.conf

rm /var/lib/nova/nova.sqlite
rm password-environment.sh
service nova-compute restart

