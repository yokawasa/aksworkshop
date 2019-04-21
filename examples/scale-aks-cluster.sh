#!/bin/bash
set -x -e

cwd=`dirname "$0"`
expr "$0" : "/.*" > /dev/null || cwd=`(cd "$cwd" && pwd)`
. $cwd/akschallenge.conf

# scale cluster nodes up to 4
az aks scale --resource-group $resource_group --name $cluster_name --node-count 4
