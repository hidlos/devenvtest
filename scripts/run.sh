#!/usr/bin/env bash

#set -ev
TRAVIS_COMMIT_RANGE="e17e329..4ffc20f"

ROOTPATH=$PWD
COMMITTED_FILES=`git diff --name-only $TRAVIS_COMMIT_RANGE`
DIRS_FOR_BUILD=`bash scripts/getDirsForBuild.sh "$COMMITTED_FILES"`
AFFECTED_NODE_MODULE_DIRS=`bash scripts/getAffectedNodeModuleDirs.sh "$COMMITTED_FILES"`

bash scripts/runTests.sh "$AFFECTED_NODE_MODULE_DIRS" "$ROOTPATH"
bash scripts/buildImages.sh "$DIRS_FOR_BUILD" "$ROOTPATH"
