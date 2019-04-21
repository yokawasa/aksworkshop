#!/bin/bash
set -x -e

cwd=`dirname "$0"`
expr "$0" : "/.*" > /dev/null || cwd=`(cd "$cwd" && pwd)`
. $cwd/akschallenge.conf

service_principal_name="acr-service-principal"

# Populate the ACR login server and resource id.
ACR_LOGIN_SERVER=$(az acr show --name $acr_name --query loginServer --output tsv)
ACR_REGISTRY_ID=$(az acr show --name $acr_name --query id --output tsv)

# Create acrpull role assignment with a scope of the ACR resource.
SP_PASSWD=$(az ad sp create-for-rbac --name http://$service_principal_name --role acrpull --scopes $ACR_REGISTRY_ID --query password --output tsv)

# Get the service principal client id.
CLIENT_ID=$(az ad sp show --id http://$service_principal_name --query appId --output tsv)

# Output used when creating Kubernetes secret.
echo "Service principal ID: $CLIENT_ID"
echo "Service principal password: $SP_PASSWD"
