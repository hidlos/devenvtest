#!/usr/bin/env bash

DIRS=$1
COMMITTED_FILES=$2

for DIR in $DIRS; do
    CURRENT_DIR=`echo $DIR | cut -d '/' -f 2-`
    if [[ $COMMITTED_FILES == *"$CURRENT_DIR"* ]]; then
	    echo $CURRENT_DIR
    fi
done
