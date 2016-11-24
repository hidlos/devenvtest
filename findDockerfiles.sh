#!/usr/bin/env bash

TRAVIS_COMMIT_RANGE="e5bdd1a..410f772"
COMMITTED_FILES=`git diff --name-only $TRAVIS_COMMIT_RANGE`
#echo $COMMITTED_FILES

DOCKER_IMAGE_DIRS=`find . -name Dockerfile -printf '%h\n'`

for dockerdir in $DOCKER_IMAGE_DIRS; do
#    if [[ "$dockerdir" == "$COMMITTED_FILES" ]]; then
    if [[ "ne dave" == "dave" ]]; then
        echo "Image $dockerdir needs to be built"
    fi
done