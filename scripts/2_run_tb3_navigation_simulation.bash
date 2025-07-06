#!/usr/bin/env bash

# Prompt the user for input
read -p "Do you want to run with display? (y/n): " user_choice

# Convert input to lowercase to handle 'Y' or 'N'
user_choice_lower=$(echo "$user_choice" | tr '[:upper:]' '[:lower:]')

# Initialize the variable
run_rviz_gazebo="false"

if [ "$user_choice_lower" == "y" ]; then
    run_rviz_gazebo="true"
fi

docker run -it --rm \
    --name tb3_simulation_client_c \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    --network host \
    -e DISABLE_ROS1_EOL_WARNINGS=1 \
    -e DISPLAY=$DISPLAY \
    -e TURTLEBOT3_MODEL=waffle \
ros1_turtlebot3_rest_api:latest bash -c \
"roslaunch nav_rest_api_turtlebot test.launch show_rviz_gazebo:=$run_rviz_gazebo"