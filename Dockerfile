FROM osrf/ros:noetic-desktop-full-focal
ENV ROS_DISTRO=noetic

SHELL ["/bin/bash", "-c"]

# Install system packages
RUN apt-get update && apt-get install -y --no-install-recommends \
      git \
      ros-$ROS_DISTRO-dwa-local-planner \
			ros-$ROS_DISTRO-slam-gmapping && \
    rm -rf /var/lib/apt/lists/*

# Setting up working directory 
# RUN useradd -ms /bin/bash ubuntu
# RUN echo 'ubuntu:asdf' | chpasswd
# RUN adduser ubuntu sudo

WORKDIR /home/ubuntu/catkin_ws/src
RUN git clone -b $ROS_DISTRO-devel https://github.com/ROBOTIS-GIT/turtlebot3.git --depth 1 --single-branch && \
      git clone -b $ROS_DISTRO-devel https://github.com/ROBOTIS-GIT/turtlebot3_simulations.git --depth 1 --single-branch
COPY ./ nav_rest_api_turtlebot/
WORKDIR /home/ubuntu/catkin_ws/
RUN apt-get update && \
      rosdep install --from-paths src --ignore-src --rosdistro=$ROS_DISTRO -y  && \
      rm -rf /var/lib/apt/lists/*
RUN . /opt/ros/$ROS_DISTRO/setup.bash && catkin_make -DCMAKE_BUILD_TYPE=Release
RUN rm -r build/

WORKDIR /home/ubuntu/catkin_ws/scripts
COPY scripts/launch_server.bash  /home/ubuntu/catkin_ws/scripts/launch_server.bash

RUN sed -i '$isource "/home/ubuntu/catkin_ws/devel/setup.bash"' /ros_entrypoint.sh

# USER ubuntu
WORKDIR /home/ubuntu/catkin_ws

ENTRYPOINT ["/ros_entrypoint.sh"]


