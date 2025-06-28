#!/bin/bash

kubectl create namespace monitoring 

helm repo add prometheus-community https://prometheus-community.github.io/helm-charts

helm repo update

helm install kube-prom-stack prometheus-community/kube-prometheus-stack \
  -n monitoring -f values.yml