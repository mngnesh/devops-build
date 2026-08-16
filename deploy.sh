#!/bin/bash

set -e

CONTAINER_NAME="devops-build-app"
IMAGE_NAME="devops-build-app"

echo "Stopping existing container..."

docker rm -f "$CONTAINER_NAME" 2>/dev/null || true

echo "Starting application..."

docker run -d \
  --name "$CONTAINER_NAME" \
  --restart unless-stopped \
  -p 80:80 \
  "$IMAGE_NAME"

echo "Application deployed successfully on port 80."
