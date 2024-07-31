#!/usr/bin/env

docker rm tb3_api_server_c tb3_simulation_client_c

# Ensure duplicate containers are removed
docker compose down

# Ensure that graphical applications like RViz and Gazebo will not face error
# appearing...
xhost +local:docker

# Build docker images if does not exist
docker build -t ros1_turtlebot3_rest_api .

# Run docker-compose.yaml
docker compose up
