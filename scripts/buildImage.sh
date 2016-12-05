#!/usr/bin/env bash

DIR=$1
ROOT_PATH=$2

function getNodeModuleVersion() {
    echo `grep -Po '(?<="version". ")[^"]*' package.json`
}

cd $ROOT_PATH/$DIR
echo "Building and publishing Docker image $DIR"
IMAGE_VERSION=`getNodeModuleVersion`
echo "Image will be tagged with $IMAGE_VERSION"
sudo docker build -t arsi/devenvtest:$IMAGE_VERSION .
sudo docker login -u="$DOCKER_USERNAME" -p="$DOCKER_PASSWORD"
sudo docker push arsi/devenvtest:$IMAGE_VERSION