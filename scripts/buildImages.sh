#!/usr/bin/env bash

DOCKER_IMAGE_DIRS=$1
ROOT_PATH=$2

function getNodeModuleVersion() {
    NODE_MODULE_VERSION=`grep -Po '(?<="version". ")[^"]*' package.json`;
    if [ "$NODE_MODULE_VERSION" == "0.0.0-development" ]; then
        echo 'latest';
    else
        echo $NODE_MODULE_VERSION;
    fi
}

for DIR in $DOCKER_IMAGE_DIRS
do
	echo "Building and publishing Docker image $DIR"
	IMAGE_VERSION=$DIR-$(getNodeModuleVersion)
	echo "Image will be tagged with $IMAGE_VERSION"
	docker build -t arsi/devenvtest:$IMAGE_VERSION .;
	docker login -e="$DOCKER_EMAIL" -u="$DOCKER_USERNAME" -p="$DOCKER_PASSWORD";
    docker push arsi/devenvtest:$IMAGE_VERSION;
done
