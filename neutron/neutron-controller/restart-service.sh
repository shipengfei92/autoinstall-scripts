#!/bin/bash

service nova-api restart
service nova-scheduler restart
service nova-conductor restart

service neutron-server restart
