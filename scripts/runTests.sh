#!/usr/bin/env bash

set -ev

# TRAVIS_COMMIT_RANGE="e5bdd1a..3b47720"
COMMITTED_FILES=`git diff --name-only $TRAVIS_COMMIT_RANGE`

NODE_MODULE_DIRS=`find . -name package.json -printf '%h\n'`

ROOTPATH=$PWD

for moduledir in $NODE_MODULE_DIRS; do
    currentdir=`echo $moduledir | cut -d '/' -f 2-`
    if [[ $COMMITTED_FILES == *"$currentdir"* ]]; then
        cd $ROOTPATH/$i;
        npm prune;
        npm install;
        npm run test:single;
    fi
done
