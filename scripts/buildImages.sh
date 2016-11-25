#!/usr/bin/env bash

#set -ev
DOCKER_IMAGE_DIRS=$1
ROOTPATH=$2

for DIR in $DOCKER_IMAGE_DIRS
do
	echo "Image $DIR needs to be built"
done
