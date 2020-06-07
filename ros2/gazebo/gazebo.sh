#!/bin/bash

REGISTRY_IMAGE=gazeboros2image:latest
CONTAINER_NAME=gazeboros2cont

docker stop $CONTAINER_NAME && docker rm $CONTAINER_NAME 

docker run -t -d \
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
