#!/bin/bash
set -x -e

cwd=`dirname "$0"`
expr "$0" : "/.*" > /dev/null || cwd=`(cd "$cwd" && pwd)`
. $cwd/akschallenge.conf

az container create -g $resource_group \
  -n loadtest \
  --image azch/loadtest \
  --restart-policy Never \
  -e SERVICE_IP=$capture_order_service_ip
