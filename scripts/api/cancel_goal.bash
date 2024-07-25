#!/usr/bin/env bash

curl --header "Content-Type: application/json" \
  --request DELETE \
  --data '{"robot_name": "robot0"}' \
  http://localhost:8080/api/goal

