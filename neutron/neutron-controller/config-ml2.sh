#!/bin/bash

cd ..
cd ..
DIR=$(pwd)
cd keystone
source $DIR/keystone/admin-openrc.sh
ML2=/etc/neutron/plugins/ml2/ml2_conf.ini
sed -i '/\[securitygroup\]/a firewall_driver = neutron.agent.linux.iptables_firewall.OVSHybridIptablesFirewallDriver\
enable_security_group = True' $ML2

