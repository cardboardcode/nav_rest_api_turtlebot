FROM osrf/ros:noetic-desktop-full-focal

SHELL ["/bin/bash", "-c"]

# Install system packages
RUN apt-get update && apt-get install -y --no-install-recommends \
      nano \
      git \
      nodejs \ 
      npm \
      ros-noetic-rosbridge-server \
      ros-noetic-dwa-local-planner \
			ros-noetic-slam-gmapping && \
    rm -rf /var/lib/apt/lists/*

# Setting up working directory 
RUN useradd -ms /bin/bash ubuntu
RUN echo 'ubuntu:asdf' | chpasswd
RUN adduser ubuntu sudo

WORKDIR /home/ubuntu/catkin_ws/src
RUN git clone -b master https://github.com/CumaOzavci/nav_rest_api.git --depth 1 --single-branch
RUN git clone -b noetic-devel https://github.com/ROBOTIS-GIT/turtlebot3.git --depth 1 --single-branch
RUN git clone -b noetic-devel https://github.com/ROBOTIS-GIT/turtlebot3_simulations.git --depth 1 --single-branch
COPY ./ nav_rest_api_turtlebot/
WORKDIR /home/ubuntu/catkin_ws/
RUN apt-get update && rosdep install --from-paths src --ignore-src --rosdistro=noetic -y
RUN . /opt/ros/noetic/setup.bash && catkin_make

WORKDIR /home/ubuntu/catkin_ws/src/nav_rest_api/server
RUN npm install
WORKDIR /home/ubuntu/catkin_ws/src/nav_rest_api/client
RUN npm install

WORKDIR /home/ubuntu/catkin_ws/scripts
COPY scripts/launch_server.bash  /home/ubuntu/catkin_ws/scripts/launch_server.bash
COPY scripts/launch_turtlebot3_gazebo_simulation.bash  /home/ubuntu/catkin_ws/scripts/launch_turtlebot3_gazebo_simulation.bash

RUN sed -i '$isource "/home/ubuntu/catkin_ws/devel/setup.bash"' /ros_entrypoint.sh

USER ubuntu
WORKDIR /home/ubuntu/catkin_ws

ENTRYPOINT ["/ros_entrypoint.sh"]


