#!/bin/bash

cd ..
cd ..

DIR=$(pwd)

cd keystone

source $DIR/keystone/admin-openrc.sh

#apt-get install neutron-server neutron-plugin-ml2 -y

sed -i "/connection = sqlite/c connection = mysql://neutron:$NEUTRON_DBPASS@controller/neutron" /etc/neutron/neutron.conf

sed -i '/auth_host =/,+5d' /etc/neutron/neutron.conf

sed -i '/\[keystone_authtoken\]/a auth_uri = http://controller:5000\
auth_host = controller\
auth_protocol = http\
auth_port = 35357\
admin_tenant_name = service\
admin_user = neutron\
admin_password = '$NEUTRON_PASS'' /etc/neutron/neutron.conf

SERVICE_TENANT_ID=$(keystone tenant-get service |awk '/id/ {print $4}')

sed -i '/\[DEFAULT\]/a auth_strategy = keystone\
\
rpc_backend = neutron.openstack.common.rpc.impl_kombu\
rabbit_host = controller\
rabbit_password = '$RABBIT_PASS'\
\
core_plugin = ml2\
service_plugins = router\
allow_overlapping_ips = True\
\
notify_nova_on_port_status_changes = True\
notify_nova_on_port_data_changes = True\
nova_url = http://controller:8774/v2\
nova_admin_username = nova\
nova_admin_tenant_id = '$SERVICE_TENANT_ID'\
nova_admin_password = '$NOVA_PASS'\
nova_admin_auth_url = http://controller:35357/v2.0'	/etc/neutron/neutron.conf


