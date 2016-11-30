#!/usr/bin/env bash

#set -ev
#TRAVIS_COMMIT_RANGE="e17e329..4ffc20f"

ROOT_PATH=$PWD
COMMITTED_FILES=`git diff --name-only $TRAVIS_COMMIT_RANGE`

NODE_MODULE_DIRS=`bash scripts/getAffectedNodeModuleDirs.sh "$COMMITTED_FILES"`
bash scripts/runTests.sh "$NODE_MODULE_DIRS" "$ROOT_PATH"

if [ -f /here ]; then
    echo "JE TAM";
else
    echo "NENI TAM";
fi


DOCKER_DIRECTORIES=`bash scripts/getDirsForBuild.sh "$COMMITTED_FILES"`
bash scripts/buildImages.sh "$DOCKER_DIRECTORIES" "$ROOT_PATH"