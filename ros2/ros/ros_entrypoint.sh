#!/bin/bash
set -e
# setup ros environment
source "/opt/ros/rolling/setup.bash"
exec "$@"