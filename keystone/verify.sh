#/bin/bash
unset OS_SERVICE_TOKEN OS_SERVICE_ENDPOINT

cd ..

TOP_DIR=$(pwd)

source $TOP_DIR/password-environment.sh

echo $ADMIN_PASS

keystone --os-username=admin --os-password=$ADMIN_PASS \
  --os-auth-url=http://controller:35357/v2.0 token-get

keystone --os-username=admin --os-password=$ADMIN_PASS \
  --os-tenant-name=admin --os-auth-url=http://controller:35357/v2.0 \
  token-get

