#!/bin/bash

USERNAME="mydockerimage31"

echo "Building Docker image..."
docker build -t $USERNAME/dev:latest .

echo "Pushing image to Docker Hub..."
docker push $USERNAME/dev:latest

echo "Build & Push completed!"