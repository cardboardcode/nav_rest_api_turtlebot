#!/usr/bin/env bash

curl --header "Content-Type: application/json" \
  --request POST \
  --data '{"robot_name": "robot0","location_x": "3.8540569683214945","location_y": "0.08975273703770789","location_th": "1.5707"}' \
  http://localhost:8080/api/goal

