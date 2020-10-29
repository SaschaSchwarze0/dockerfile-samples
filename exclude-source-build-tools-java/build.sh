#!/bin/bash

set -euo pipefail

echo "Pulling base images ..."
docker pull adoptopenjdk:11-jre-openj9
docker pull maven:3-jdk-11-openj9

echo "Building bad image ..."
docker build -t docker-exclude-source-build-tools-java:bad -f Dockerfile.bad .
badImageSize=$(docker image inspect docker-exclude-source-build-tools-java:bad --format='{{.Size}}')
echo

echo "Building good image ..."
docker build -t docker-exclude-source-build-tools-java:good -f Dockerfile.good .
goodImageSize=$(docker image inspect docker-exclude-source-build-tools-java:good --format='{{.Size}}')
echo

echo "Cleaning up test images ..."
docker rmi docker-exclude-source-build-tools-java:bad
docker rmi docker-exclude-source-build-tools-java:good
echo

echo "Size of bad image:  ${badImageSize} bytes"
echo "Size of good image: ${goodImageSize} bytes"
