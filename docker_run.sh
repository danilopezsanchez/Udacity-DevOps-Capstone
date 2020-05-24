#!/usr/bin/env bash

# Build image
docker build --tag=capstone .

# List docker images
docker image ls