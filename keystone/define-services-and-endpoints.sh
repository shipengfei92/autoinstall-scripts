#/bin/bash

cd ..

TOP_DIR=$(pwd)

source $TOP_DIR/password-environment.sh

export OS_SERVICE_TOKEN=$ADMIN_TOKEN
export OS_SERVICE_ENDPOINT=http://controller:35357/v2.0

keystone service-create --name=keystone --type=identity \
  --description="OpenStack Identity"

keystone endpoint-create \
  --service-id=$(keystone service-list | awk '/ identity / {print $2}') \
  --publicurl=http://controller:5000/v2.0 \
  --internalurl=http://controller:5000/v2.0 \
  --adminurl=http://controller:35357/v2.0

