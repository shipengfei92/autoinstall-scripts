#!/bin/bash

apt-get install neutron-plugin-ml2 neutron-plugin-openvswitch-agent openvswitch-datapath-dkms \
  neutron-l3-agent neutron-dhcp-agent -y
