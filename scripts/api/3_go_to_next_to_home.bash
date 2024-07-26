#!/usr/bin/env bash

curl --header "Content-Type: application/json" \
  --request POST \
  --data '{"robot_name": "robot0","location_x": "0.09800893478101023","location_y": "1.1154263339132284","location_th": "1.5707"}' \
  http://localhost:8080/api/goal

