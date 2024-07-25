#!/usr/bin/env bash

curl --header "Content-Type: application/json" \
  --request POST \
  --data '{ "robot_name" : "robot0","linear_speed" : "0","angular_speed" : "0"}' \
  http://localhost:8080/api/twist

