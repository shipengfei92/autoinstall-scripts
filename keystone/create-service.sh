#!/bin/bash

cd ..

TOP_DIR=$(pwd)

source $TOP_DIR/password-environment.sh

export OS_SERVICE_TOKEN=$ADMIN_TOKEN
export OS_SERVICE_ENDPOINT=http://controller:35357/v2.0

keystone tenant-create --name=service --description="Service Tenant"

unset OS_SERVICE_TOKEN OS_SERVICE_ENDPOINT

