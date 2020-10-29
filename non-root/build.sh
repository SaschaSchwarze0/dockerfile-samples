#!/bin/bash

set -euo pipefail

echo "Pulling base image ..."
docker pull node:12-alpine

echo "Building good image ..."
docker build -t non-root:good -f Dockerfile.good .
echo

echo "Building good image with user..."
docker build -t non-root:good-withuser -f Dockerfile.good-withuser .
echo
