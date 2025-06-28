#!/bin/bash

kubectl create namespace argocd

helm repo add argo https://argoproj.github.io/argo-helm

helm repo update

htpasswd -nbBC 10 "" "<your_pass>" | tr -d ':\n' | sed 's/^\$2y/\$2a/'

# Run this after the above command to create the argocd-values.yml file
# helm install argocd argo/argo-cd -n argocd -f argocd-values.yml

# To uninstall
# helm uninstall argocd -n argocd