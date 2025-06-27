#!/bin/bash

# If you have not installed istioctl yet
# curl -L https://istio.io/downloadIstio | sh -
# cp -r istio-*/bin/* /usr/local/bin/

istioctl install --set profile=demo -y

istioctl analyze

kubectl label namespace default istio-injection=enabled