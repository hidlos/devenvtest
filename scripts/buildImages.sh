#!/usr/bin/env bash

DOCKER_IMAGE_DIRS=$1
ROOT_PATH=$2

function getNodeModuleVersion() {
    NODE_MODULE_VERSION=`grep -Po '(?<="version". ")[^"]*' package.json`
    echo $NODE_MODULE_VERSION
}

for DIR in $DOCKER_IMAGE_DIRS
do
    cd $ROOT_PATH/$DIR
	echo "Building and publishing Docker image $DIR"
	IMAGE_VERSION=`getNodeModuleVersion`
	echo "Image will be tagged with $IMAGE_VERSION"
	docker build -t arsi/devenvtest:$IMAGE_VERSION .
	docker login -u="$DOCKER_USERNAME" -p="$DOCKER_PASSWORD"
    docker push arsi/devenvtest:$IMAGE_VERSION
done
