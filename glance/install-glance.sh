#!/bin/bash

cd ..

DIR=$(pwd)
GLANCE_PATH=/etc/glance

source $DIR/password-environment.sh
source $DIR/keystone/admin-openrc.sh

apt-get install glance python-glanceclient -y

sed -i '/connection =/a connection = mysql://glance:'$GLANCE_DBPASS'@controller/glance' $GLANCE_PATH/glance-api.conf
sed -i '/connection =/a connection = mysql://glance:'$GLANCE_DBPASS'@controller/glance' $GLANCE_PATH/glance-registry.conf

rm /var/lib/glance/glance.sqlite

su -s /bin/sh -c "glance-manage db_sync" glance

keystone user-create --name=glance --pass=$GLANCE_PASS --email=glance@example.com

keystone user-role-add --user=glance --tenant=service --role=admin

sed -i '/auth_host =/,+5d' $GLANCE_PATH/glance-api.conf
sed -i '/auth_host =/,+5d' $GLANCE_PATH/glance-registry.conf

sed -i '/\[keystone_authtoken\]/a auth_uri = http://controller:5000\
auth_host = controller\
auth_port = 35357\
auth_protocol = http\
admin_tenant_name = service\
admin_user = glance\
admin_password = '$GLANCE_PASS'' $GLANCE_PATH/glance-api.conf

sed -i '/\[keystone_authtoken\]/a auth_uri = http://controller:5000\
auth_host = controller\
auth_port = 35357\
auth_protocol = http\
admin_tenant_name = service\
admin_user = glance\
admin_password = '$GLANCE_PASS'' $GLANCE_PATH/glance-registry.conf



sed -i '/\[paste_deploy\]/a flavor = keystone' $GLANCE_PATH/glance-api.conf
sed -i '/\[paste_deploy\]/a flavor = keystone' $GLANCE_PATH/glance-registry.conf

keystone service-create --name=glance --type=image \
  --description="OpenStack Image Service"

keystone endpoint-create \
  --service-id=$(keystone service-list | awk '/ image / {print $2}') \
  --publicurl=http://controller:9292 \
  --internalurl=http://controller:9292 \
  --adminurl=http://controller:9292

service glance-registry restart
service glance-api restart




