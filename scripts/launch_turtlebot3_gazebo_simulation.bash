#!/usr/bin/env bash

export TURTLEBOT3_MODEL=waffle
source devel/setup.bash
roslaunch nav_rest_api_turtlebot test.launch
