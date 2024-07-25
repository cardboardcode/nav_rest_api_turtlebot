#!/usr/bin/env

xhost +local:docker

# Build docker images if does not exist
docker build -t ros1_turtlebot3_rest_api .

# Run docker-compose.yaml
docker compose up
