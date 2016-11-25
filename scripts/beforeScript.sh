#!/usr/bin/env bash


TRAVIS_COMMIT_RANGE="e17e329..4ffc20f"

COMMITTED_FILES=`git diff --name-only $TRAVIS_COMMIT_RANGE`
echo `bash scripts/getDirsForBuild.sh "$COMMITTED_FILES"`

ROOTPATH=$PWD
for i in $DIRS_FOR_BUILD;
do
        cd $ROOTPATH/$i;
        npm prune;
done


echo `bash scripts/getAffectedNodeModuleDirs.sh "$COMMITTED_FILES"`
