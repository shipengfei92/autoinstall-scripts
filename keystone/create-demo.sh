#!/bin/bash

cd ..

TOP_DIR=$(pwd)

source $TOP_DIR/password-environment.sh

export OS_SERVICE_TOKEN=$ADMIN_TOKEN
export OS_SERVICE_ENDPOINT=http://controller:35357/v2.0

keystone user-create --name=demo --pass=DEMO_PASS --email=DEMO_EMAIL

keystone tenant-create --name=demo --description="Demo Tenant"

keystone user-role-add --user=demo --role=_member_ --tenant=demo

unset OS_SERVICE_TOKEN OS_SERVICE_ENDPOINT
