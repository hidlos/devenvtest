#!/usr/bin/env bash

#set -ev
#TRAVIS_COMMIT_RANGE="e17e329..4ffc20f"

ROOTPATH=$PWD
COMMITTED_FILES=`git diff --name-only $TRAVIS_COMMIT_RANGE`

DOCKER_DIRS=`bash scripts/getDirsForBuild.sh "$COMMITTED_FILES"`
bash scripts/buildImages.sh "$DOCKER_DIRS" "$ROOTPATH"

NODE_MODULE_DIRS=`bash scripts/getAffectedNodeModuleDirs.sh "$COMMITTED_FILES"`
bash scripts/runTests.sh "$NODE_MODULE_DIRS" "$ROOTPATH"

