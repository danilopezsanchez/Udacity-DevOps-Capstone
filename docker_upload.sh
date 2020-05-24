#!/usr/bin/env bash
# This file tags and uploads an image to Docker Hub

# Create dockerpath
dockerpath=overrider/capstonetest

# Authenticate & tag
echo "Docker ID and Image: $dockerpath"
docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD
docker tag capstonetest $dockerpath

# Push image to a docker repository
docker push $dockerpath