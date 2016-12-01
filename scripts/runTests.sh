#!/usr/bin/env bash

AFFECTED_DIRS=$1
ROOT_PATH=$2

for DIR in $AFFECTED_DIRS
do
	cd $ROOT_PATH/$DIR
        npm prune
        npm install
        npm run test:single
        echo "jsem tu"
done
