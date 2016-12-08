#!/usr/bin/env bash

function getAffectedDirs() {
    DIRS=$1
    AFFECTED_FILES=`getAffectedFilesFromCommit`

    for DIR in $DIRS; do
        CURRENT_DIR=`echo $DIR | cut -d '/' -f 2-`
        if [[ $AFFECTED_FILES == *"$CURRENT_DIR"* ]]; then
            echo $CURRENT_DIR
        fi
    done
}