#!/usr/bin/env bash

docker exec -it tb3_simulation_client_c bash -c "source /ros_entrypoint.sh && rostopic pub /change_map std_msgs/String 'L3' --once"
