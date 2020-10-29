#!/bin/bash

set -euo pipefail

echo "Pulling base images ..."
docker pull gcr.io/distroless/nodejs:12
docker pull node:12-alpine
docker pull ubuntu

echo "Building bad image ..."
docker build -t base-image:bad -f Dockerfile.bad .
badImageSize=$(docker image inspect base-image:bad --format='{{.Size}}')
echo

echo "Building good image (Alpine) ..."
docker build -t base-image:good-alpine -f Dockerfile.good-alpine .
goodAlpineImageSize=$(docker image inspect base-image:good-alpine --format='{{.Size}}')
echo

echo "Building good image (Distroless) ..."
docker build -t base-image:good-distroless -f Dockerfile.good-distroless .
goodDistrolessImageSize=$(docker image inspect base-image:good-distroless --format='{{.Size}}')
echo

echo "Cleaning up test images ..."
docker rmi base-image:bad
docker rmi base-image:good-alpine
docker rmi base-image:good-distroless
echo

echo "Size of bad image:               ${badImageSize} bytes"
echo "Size of good image (Alpine):     ${goodAlpineImageSize} bytes"
echo "Size of good image (Distroless): ${goodDistrolessImageSize} bytes"
