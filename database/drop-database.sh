#!/bin/bash

cd ..

TOP_DIR=$(pwd)

#echo $TOP_DIR
source	$TOP_DIR/password-environment.sh

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
	NAME=${project[i]}
	PASS=${passwd[i]}

	echo $NAME;
	echo $PASS;

	mysql -uroot -p$DBPASS -e "
	
	drop database $NAME;

	exit
	"
done
