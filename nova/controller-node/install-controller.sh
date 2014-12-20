#!/bin/bash

cd ..

cd ..

DIR=$(pwd)
MY_IP=controller

source $DIR/password-environment.sh
cd keystone
source $DIR/keystone/admin-openrc.sh

echo "nameserver 202.120.2.101" > /etc/resolv.conf

sed -i "s/us.archive.ubuntu.com/ftp.sjtu.edu.cn/g" /etc/apt/sources.list

apt-get update

apt-get install nova-api nova-cert nova-conductor nova-consoleauth \
  nova-novncproxy nova-scheduler python-novaclient -y

echo "
[database]
connection = mysql://nova:$NOVA_DBPASS@controller/nova" >> /etc/nova/nova.conf



sed -i '/\[DEFAULT\]/a rpc_backend = rabbit\
rabbit_host = controller\
rabbit_password = '$RABBIT_PASS'\
\
my_ip = '$MY_IP'\
vncserver_listen = '$MY_IP'\
vncserver_proxyclient_address = '$MY_IP'\
\
auth_strategy = keystone' /etc/nova/nova.conf

echo "
[keystone_authtoken]

auth_uri = http://$MY_IP:5000
auth_host = $MY_IP
auth_port = 35357
auth_protocol = http
admin_tenant_name = service
admin_user = nova
admin_password = $NOVA_PASS" >> /etc/nova/nova.conf

rm /var/lib/nova/nova.sqlite

su -s /bin/sh -c "nova-manage db sync" nova

keystone user-create --name=nova --pass=$NOVA_PASS --email=nova@example.com

keystone user-role-add --user=nova --tenant=service --role=admin



keystone service-create --name=nova --type=compute \
  --description="OpenStack Compute"

keystone endpoint-create \
  --service-id=$(keystone service-list | awk '/ compute / {print $2}') \
  --publicurl=http://controller:8774/v2/%\(tenant_id\)s \
  --internalurl=http://controller:8774/v2/%\(tenant_id\)s \
  --adminurl=http://controller:8774/v2/%\(tenant_id\)s

service nova-api restart
service nova-cert restart
service nova-consoleauth restart
service nova-scheduler restart
service nova-conductor restart
service nova-novncproxy restart


nova image-list




