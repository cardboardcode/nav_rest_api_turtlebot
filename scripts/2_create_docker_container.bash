docker kill ros1_turtlebot3_rest_api_c
docker rm ros1_turtlebot3_rest_api_c

xhost +local:docker

docker run -it \
 --name ros1_turtlebot3_rest_api_c \
 --net=host \
 ros1_turtlebot3_rest_api:latest /bin/bash
