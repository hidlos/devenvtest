#!/usr/bin/env bash

COMMITTED_FILES=$1
NODE_MODULES=`find . -name package.json -printf '%h\n'`

echo "`bash scripts/getAffectedDirs.sh "$NODE_MODULES" "$COMMITTED_FILES"`"

#for NODE_MODULE in $NODE_MODULES; do
#    CURRENT_DIR=`echo $NODE_MODULE | cut -d '/' -f 2-`
#    if [[ $COMMITTED_FILES == *"$CURRENT_DIR"* ]]; then
#	echo $CURRENT_DIR
#    fi
#done
