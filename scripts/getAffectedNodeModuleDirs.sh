#!/usr/bin/env bash

COMMITTED_FILES=$1
NODE_MODULES=`find . -name package.json -printf '%h\n'`

bash scripts/getAffectedDirs.sh "$NODE_MODULES" "$COMMITTED_FILES"
