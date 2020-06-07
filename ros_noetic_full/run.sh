#!/bin/bash

REGISTRY_IMAGE=custom2
CONTAINER_NAME=ros_noetic_custom_cont

#docker stop $CONTAINER_NAME && docker rm $CONTAINER_NAME 

docker run -it --rm \
    --gpus all \
    --env="DISPLAY" \
    --volume="/etc/group:/etc/group:ro" \
    --volume="/etc/passwd:/etc/passwd:ro" \
    --volume="/etc/shadow:/etc/shadow:ro" \
    --volume="/etc/sudoers.d:/etc/sudoers.d:ro" \
    --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
    --net host \
    --privileged \
    --name $CONTAINER_NAME \
     $REGISTRY_IMAGE