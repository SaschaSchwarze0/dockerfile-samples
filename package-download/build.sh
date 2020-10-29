#!/bin/bash

set -euo pipefail

echo "Pulling base image ..."
docker pull ubuntu

echo "Building bad image ..."
docker build -t docker-package-download:bad -f Dockerfile.bad .
badImageSize=$(docker image inspect docker-package-download:bad --format='{{.Size}}')
echo

echo "Building good image ..."
docker build -t docker-package-download:good -f Dockerfile.good .
goodImageSize=$(docker image inspect docker-package-download:good --format='{{.Size}}')
echo

echo "Cleaning up test images ..."
docker rmi docker-package-download:bad
docker rmi docker-package-download:good
echo

echo "Size of bad image:  ${badImageSize} bytes"
echo "Size of good image: ${goodImageSize} bytes"
