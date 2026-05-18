#!/bin/bash

USERNAME="mydockerimage31"
CONTAINER="react-app"

echo "Pulling latest image..."
docker pull $USERNAME/dev:latest

echo "Stopping old container..."
docker stop $CONTAINER || true
docker rm $CONTAINER || true

echo "Running new container..."
docker run -d -p 80:80 --name $CONTAINER $USERNAME/dev:latest

echo "Deployment done!"
