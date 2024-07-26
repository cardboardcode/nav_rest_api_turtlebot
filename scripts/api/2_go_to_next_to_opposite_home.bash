#!/usr/bin/env bash

curl --header "Content-Type: application/json" \
  --request POST \
  --data '{"robot_name": "robot0","location_x": "3.80250850120499","location_y": "1.0450816557708476","location_th": "1.5707"}' \
  http://localhost:8080/api/goal

