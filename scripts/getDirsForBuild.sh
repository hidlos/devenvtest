#!/usr/bin/env bash

COMMITTED_FILES=$1
DOCKER_IMAGE_DIRS=`find . -name Dockerfile -printf '%h\n'`

bash scripts/getAffectedDirs.sh "$DOCKER_IMAGE_DIRS" "$COMMITTED_FILES"
