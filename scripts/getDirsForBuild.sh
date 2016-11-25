#!/usr/bin/env bash

COMMITTED_FILES=$1
DOCKER_IMAGE_DIRS=`find . -name Dockerfile -printf '%h\n'`

echo `bash scripts/getAffectedDirs.sh "$DOCKER_IMAGE_DIRS" "$COMMITTED_FILES"`

#for DOCKER_DIR in $DOCKER_IMAGE_DIRS; do
#    CURRENT_DIR=`echo $DOCKER_DIR | cut -d '/' -f 2-`
#    if [[ $COMMITTED_FILES == *"$CURRENT_DIR"* ]]; then
#	echo $CURRENT_DIR
#    fi
#done
