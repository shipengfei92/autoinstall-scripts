#!/bin/bash

cd ..

TOP_DIR=$(pwd)

source $TOP_DIR/password-environment.sh

echo $DBPASS

project=(keystone
	glance
	nova 
	neutron
	cinder
	heat
	ceilometer
	);

passwd=($KEYSTONE_DBPASS
	$GLANCE_DBPASS
	$NOVA_DBPASS
	$NEUTRON_DBPASS
	$CINDER_DBPASS
	$HEAT_DBPASS
	$CEILOMETER_DBPASS
	);

for ((i=0;i<=6;i++));do
	#echo "~~~~~~~~~~"
	NAME=${project[i]};
	PASS=${passwd[i]};

	echo $NAME;
	echo $PASS;

	mysql -uroot -p$DBPASS -e "

	CREATE DATABASE $NAME;

	GRANT ALL PRIVILEGES ON $NAME.* TO '$NAME'@'localhost' \
  	IDENTIFIED BY '$PASS';

	GRANT ALL PRIVILEGES ON $NAME.* TO '$NAME'@'%' \
  	IDENTIFIED BY '$PASS';

exit
"

done
