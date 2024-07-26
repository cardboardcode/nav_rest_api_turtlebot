#!/usr/bin/env bash

curl --header "Content-Type: application/json" \
  --request POST \
  --data '{"robot_name": "robot0","location_x": "0.0378888136219438","location_y": "0.0037114590471162144","location_th": "1.5707"}' \
  http://localhost:8080/api/goal

