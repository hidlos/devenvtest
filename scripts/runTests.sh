#!/usr/bin/env bash

#set -ev
AFFECTED_DIRS=$1
ROOTPATH=$2

for DIR in $AFFECTED_DIRS
do
	cd $ROOTPATH/$DIR;
        npm prune;
        npm install;
        npm run test:single;
done
