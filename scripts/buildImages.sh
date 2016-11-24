#!/usr/bin/env bash

set -ev

# TRAVIS_COMMIT_RANGE="e5bdd1a..3b47720"
COMMITTED_FILES=`git diff --name-only $TRAVIS_COMMIT_RANGE`

DOCKER_IMAGE_DIRS=`find . -name Dockerfile -printf '%h\n'`

for dockerdir in $DOCKER_IMAGE_DIRS; do
    currentdir=`echo $dockerdir | cut -d '/' -f 2-`
    if [[ $COMMITTED_FILES == *"$currentdir"* ]]; then
        echo "Image $dockerdir needs to be built"
    fi
done
