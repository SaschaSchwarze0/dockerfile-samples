#!/bin/bash

set -euo pipefail

echo "Pulling base image ..."
docker pull node:12-alpine

echo "Building bad image ..."
docker build -t compile-at-build-time-react:bad -f Dockerfile.bad .
badImageSize=$(docker image inspect compile-at-build-time-react:bad --format='{{.Size}}')
echo

echo "Building good image ..."
docker build -t compile-at-build-time-react:good -f Dockerfile.good .
goodImageSize=$(docker image inspect compile-at-build-time-react:good --format='{{.Size}}')
echo

echo "Cleaning up test images ..."
docker rmi compile-at-build-time-react:bad
docker rmi compile-at-build-time-react:good
echo

echo "Size of bad image:  ${badImageSize} bytes"
echo "Size of good image: ${goodImageSize} bytes"
