#!/usr/bin/env bash

# This API call can also be used to add new robot.

curl --header "Content-Type: application/json" \
  --request POST \
  --data '{"robot_name": "robot0", "ip_address": "localhost", "port": "8000", "location_x": "13", location_y: "20", "location_th": "1"}' \
  http://localhost:8080/api/robot

