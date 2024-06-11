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
RUN git clone -b master https://github.com/CumaOzavci/nav_rest_api.git
RUN git clone -b noetic-devel https://github.com/ROBOTIS-GIT/turtlebot3.git
RUN git clone -b noetic-devel https://github.com/ROBOTIS-GIT/turtlebot3_simulations.git
RUN git clone -b main https://github.com/CumaOzavci/nav_rest_api_turtlebot
WORKDIR /home/ubuntu/catkin_ws/
RUN apt-get update && rosdep install --from-paths src --ignore-src --rosdistro=noetic -y
RUN . /opt/ros/noetic/setup.bash && catkin_make

WORKDIR /home/ubuntu/catkin_ws/src/nav_rest_api/server
RUN npm install
WORKDIR /home/ubuntu/catkin_ws/src/nav_rest_api/client
RUN npm install

USER ubuntu
WORKDIR /home/ubuntu/catkin_ws
RUN source devel/setup.bash


