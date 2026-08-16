#!/bin/bash

set -e

IMAGE_NAME="devops-build-app"

echo "Building Docker image: $IMAGE_NAME"

docker build -t "$IMAGE_NAME" .

echo "Docker image built successfully: $IMAGE_NAME"
