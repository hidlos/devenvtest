#!/usr/bin/env bash
set -ev
for i in $DIRECTORIES;
    do
        cd $ROOTPATH/$i;
        npm install;
        npm run test:single;
    done
