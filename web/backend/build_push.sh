#!/bin/bash

docker buildx create --use

docker buildx build --platform linux/amd64,linux/arm64 \
  -t us-west1-docker.pkg.dev/playground-459722/wingie/backend:latest \
  --push .
