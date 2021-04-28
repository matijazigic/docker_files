#!/bin/bash

REGISTRY_IMAGE=ros2image:latest
CONTAINER_NAME=ros2cont

docker stop $CONTAINER_NAME && docker rm $CONTAINER_NAME 

docker run -it \
    --gpus all \
    --rm \
    --env="DISPLAY" \
    --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
    --net host \
    --privileged \
    --name $CONTAINER_NAME \
    $REGISTRY_IMAGE