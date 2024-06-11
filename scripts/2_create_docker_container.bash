docker kill ros1_turtlebot3_rest_api_c
docker rm ros1_turtlebot3_rest_api_c

xhost +local:docker

docker run -it --rm \
 --name ros1_turtlebot3_rest_api_c \
 -e DISPLAY=$DISPLAY \
 -v /tmp/.X11-unix:/tmp/.X11-unix \
 --net=host \
 ros1_turtlebot3_rest_api:latest /bin/bash
