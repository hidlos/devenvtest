#!/usr/bin/env bash

DOCKER_IMAGE_DIRS=`($(find . -name package.json -printf '%h\n'))`
echo $DOCKER_IMAGE_DIRS