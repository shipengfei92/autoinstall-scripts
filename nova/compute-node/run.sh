#!/bin/bash

NODE=$1
NAME=$2
DIR=/tmp
cat install-compute-node.sh |ssh root@$NODE tee $DIR/compute.sh

cd ..
cd ..

scp password-environment.sh root@$NODE:$DIR

cd nova/compute-node

ssh root@$NODE "cd $DIR;
chmod +x compute.sh;
./compute.sh $NODE $NAME;
rm compute.sh;"
