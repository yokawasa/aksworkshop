#!/bin/bash
set -x -e

cwd=`dirname "$0"`
expr "$0" : "/.*" > /dev/null || cwd=`(cd "$cwd" && pwd)`
. $cwd/akschallenge.conf

az aks get-versions -l $region -o table
kubernetesVersionLatest=$(az aks get-versions -l ${region} --query 'orchestrators[-1].orchestratorVersion' -o tsv)

az aks create --resource-group $resource_group \
  --name $cluster_name \
  --enable-addons monitoring \
  --kubernetes-version $kubernetesVersionLatest \
  --generate-ssh-keys --location $region
