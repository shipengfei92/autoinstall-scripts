#!/bin/bash

cd ..

DIR=$(pwd)
GLANCE_PATH=/etc/glance

source $DIR/password-environment.sh
source $DIR/keystone/admin-openrc.sh

wget http://cdn.download.cirros-cloud.net/0.3.2/cirros-0.3.2-x86_64-disk.img

glance image-create --name "cirros-0.3.2-x86_64" --disk-format qcow2 \
  --container-format bare --is-public True --progress < cirros-0.3.2-x86_64-disk.img

glance image-list


