#!/bin/bash

cd ..

TOP_DIR=$(pwd)

source $TOP_DIR/password-environment.sh

apt-get install keystone -y

sed -i '/connection =/c connection = mysql://keystone:'$KEYSTONE_DBPASS'@controller/keystone' /etc/keystone/keystone.conf
sed -i '/\#admin_token/a admin_token = '$ADMIN_TOKEN'' /etc/keystone/keystone.conf
sed -i '/\#log_dir/a log_dir = /var/log/keystone ' /etc/keystone/keystone.conf

rm /var/lib/keystone/keystone.db

su -s /bin/sh -c "keystone-manage db_sync" keystone

service keystone restart

(crontab -l -u keystone 2>&1 | grep -q token_flush) || \
echo '@hourly /usr/bin/keystone-manage token_flush >/var/log/keystone/keystone-tokenflush.log 2>&1' >> /var/spool/cron/crontabs/keystone
