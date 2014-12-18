#!/bin/bash

cd ..

TOP_DIR=$(pwd)

source $TOP_DIR/password-environment.sh

apt-get install rabbitmq-server -y

rabbitmqctl change_password guest RABBIT_PASS
