#!/bin/bash

SERVICE_EXTERNAL_IP=$(kubectl get service captureorder -o jsonpath="{.status.loadBalancer.ingress[*].ip}")

curl -d '{"EmailAddress": "email@domain.com", "Product": "prod-1", "Total": 100}' -H "Content-Type: application/json" -X POST http://${SERVICE_EXTERNAL_IP}/v1/order
