#!/bin/bash

kubectl apply -f https://github.com/cert-manager/cert-manager/releases/latest/download/cert-manager.yaml

kubectl apply -f cloudflare-api-token-secret.yaml
