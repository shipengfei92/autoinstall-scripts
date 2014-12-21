#!/bin/bash

cd ..
cd ..

DIR=$(pwd)

cd keystone

source $DIR/keystone/admin-openrc.sh

sed -i '/\[DEFAULT\]/a network_api_class = nova.network.neutronv2.api.API\
neutron_url = http://controller:9696\
neutron_auth_strategy = keystone\
neutron_admin_tenant_name = service\
neutron_admin_username = neutron\
neutron_admin_password = '$NEUTRON_PASS'\
neutron_admin_auth_url = http://controller:35357/v2.0\
linuxnet_interface_driver = nova.network.linux_net.LinuxOVSInterfaceDriver\
firewall_driver = nova.virt.firewall.NoopFirewallDriver\
security_group_api = neutron\
' /etc/nova/nova.conf


