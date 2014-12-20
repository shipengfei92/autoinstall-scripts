#/bin/bash

cd ..
cd ..
$DIR=%(pwd)

cd keystone/
source $DIR/keystone/admin-openrc.sh

nova image-list
