#!/bin/bash

echo "install keystone"
./install-keystone.sh

echo "create admin user"
./create-admin.sh

echo "create demo user"
./create-demo.sh

echo "create service tenant"
./create-service.sh
