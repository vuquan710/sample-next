#!/bin/bash
set -e

CONTAINER_NAME=next_app_prod

echo "Building Docker image..."
docker-compose build

echo "Stopping existing container..."
docker stop $CONTAINER_NAME || true
docker rm $CONTAINER_NAME || true

echo "Starting container..."
docker-compose up -d

echo "Deployment complete!"
