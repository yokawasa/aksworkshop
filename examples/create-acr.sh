#!/bin/bash
set -x -e

cwd=`dirname "$0"`
expr "$0" : "/.*" > /dev/null || cwd=`(cd "$cwd" && pwd)`
. $cwd/akschallenge.conf

az acr create --resource-group $resource_group \
  --name $acr_name \
  --sku Standard \
  --location $region
