#!/bin/bash

set -euo pipefail

echo "Pulling base image ..."
docker pull ubuntu

echo "Building bad image ..."
docker build -t docker-package-installation:bad -f Dockerfile.bad .
badImageSize=$(docker image inspect docker-package-installation:bad --format='{{.Size}}')
echo

echo "Building good image ..."
docker build -t docker-package-installation:good -f Dockerfile.good .
goodImageSize=$(docker image inspect docker-package-installation:good --format='{{.Size}}')
echo

echo "Cleaning up test images ..."
docker rmi docker-package-installation:bad
docker rmi docker-package-installation:good
echo

echo "Size of bad image:  ${badImageSize} bytes"
echo "Size of good image: ${goodImageSize} bytes"
