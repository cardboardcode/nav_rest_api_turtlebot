#!/usr/bin/env bash

docker exec -it tb3_simulation_client_c bash -c "source /ros_entrypoint.sh && rostopic pub /autodock_action/goal autodock_core/AutoDockingActionGoal {} --once"
