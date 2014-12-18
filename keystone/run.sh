#!/bin/bash

export OS_SERVICE_TOKEN=$ADMIN_TOKEN
export OS_SERVICE_ENDPOINT=http://controller:35357/v2.0

echo "install keystone"
./install-keystone.sh

echo "create admin user"
./create-admin.sh

echo "create demo user"
./create-demo.sh

echo "create service tenant"
./create-service.sh
