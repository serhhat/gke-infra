#!/bin/bash

kubectl apply -f https://github.com/cert-manager/cert-manager/releases/latest/download/cert-manager.yaml

kubectl apply -f cloudflare-api-token-secret.yml

sleep 10

kubectl apply -f cluster-issuer.yml

kubectl apply -f certificate.yml