#!/bin/bash

HOST_WORKDIR=`pwd`
DOCKER_DIR=/root/workspace
IMAGE_NAME=`cat docker/image_name.txt`
IMAGE_TAG=`cat docker/version.txt`
DOCKER_IMAGE=${IMAGE_NAME}:${IMAGE_TAG}

ARCH=`arch`
OS_TYPE=`uname`
echo $ARCH
echo $OS_TYPE
if [ $OS_TYPE = "Darwin" ]
then
    docker run \
		--platform linux/arm64 \
        -v ${HOST_WORKDIR}:${DOCKER_DIR} \
        -it --rm \
        --net host \
        --name ${IMAGE_NAME} ${DOCKER_IMAGE} 
else
    docker run \
        -v ${HOST_WORKDIR}:${DOCKER_DIR} \
        -it --rm \
        --net host \
        --name ${IMAGE_NAME} ${DOCKER_IMAGE} 
fi