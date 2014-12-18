#!/bin/bash
cd ..
TOP_DIR=$(pwd)
source $TOP_DIR/password-environment.sh

echo $DEMO_PASS

export OS_USERNAME=demo
export OS_PASSWORD=$DEMO_PASS
export OS_TENANT_NAME=demo
export OS_AUTH_URL=http://controller:35357/v2.0
