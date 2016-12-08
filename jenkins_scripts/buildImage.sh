#!/usr/bin/env bash

DIR=$1

function getNodeModuleVersion() {
    echo `grep -Po '(?<="version". ")[^"]*' package.json`
}
ls
cd $WORKSPACE/$DIR
echo "Building and publishing Docker image $DIR"
IMAGE_VERSION=`getNodeModuleVersion`
echo "Image will be tagged with $IMAGE_VERSION"
sudo docker build -t arsi/devenvtest:$IMAGE_VERSION .
sudo docker login -u="$DOCKER_USERNAME" -p="$DOCKER_PASSWORD"
sudo docker push arsi/devenvtest:$IMAGE_VERSION
#curl -u "092C1B14A8E09DDD3337:v1EK3ipZjphv2vG6kBv9yvXdviZnfZEnMguW3W8S" \
#  -X POST \
#  -H 'Accept: application/json' \
#  -H 'Content-Type: application/json' \
#  -d '{"inServiceStrategy":{"launchConfig":{"tty":true, "vcpu":1, "imageUuid":"docker:arsi/devenvtest:$IMAGE_VERSION"}}, "toServiceStrategy":null}' \
#  'http://192.168.50.207:8080/v2-beta/projects/1a5/services/1s6/?action=upgrade'


curl -u "092C1B14A8E09DDD3337:v1EK3ipZjphv2vG6kBv9yvXdviZnfZEnMguW3W8S" -X POST -H 'Accept: application/json' -H 'Content-Type: application/json' -d '{"inServiceStrategy":{"launchConfig":{"tty":true, "vcpu":1, "imageUuid":"docker:arsi/devenvtest:0.0.0-development"}}, "toServiceStrategy":null}' 'http://192.168.50.207:8080/v2-beta/projects/1a5/services/1s6/?action=upgrade'
