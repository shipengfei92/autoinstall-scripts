#!/bin/bash
cd ..
TOP_DIR=$(pwd)
source $TOP_DIR/password-environment.sh

export OS_USERNAME=admin
export OS_PASSWORD=$ADMIN_PASS
export OS_TENANT_NAME=admin
export OS_AUTH_URL=http://controller:35357/v2.0
