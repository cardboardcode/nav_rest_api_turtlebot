#!/usr/bin/env bash

curl --header "Content-Type: application/json" \
  --request GET \
  --data '{"robot_name": "robot0"}' \
  http://localhost:8080/api/robot

