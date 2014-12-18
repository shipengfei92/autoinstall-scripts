#!/bin/bash

cd ..

TOP_DIR=$(pwd)

source $TOP_DIR/password-environment.sh

echo $ADMIN_TOKEN

export OS_SERVICE_TOKEN=$ADMIN_TOKEN
export OS_SERVICE_ENDPOINT=http://controller:35357/v2.0

keystone user-role-remove --user admin --role admin --tenant admin
keystone user-role-remove --user demo  --role demo  --tenant demo

keystone user-delete admin
keystone user-delete demo

keystone role-delete admin
keystone role-delete demo

keystone tenant-delete admin
keystone tenant-delete demo






