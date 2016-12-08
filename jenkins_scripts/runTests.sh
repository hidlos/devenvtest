#!/usr/bin/env bash

source $WORKSPACE/jenkins_scripts/getAffectedDirs.sh

function getModuleDirectories() {
    echo `find . -name package.json -printf '%h\n'`
}

function getDirectoriesForTest() {
    MODULES_DIRS=`getModuleDirectories`
    echo `getAffectedDirs $MODULES_DIRS`
}

function runTestForDirectory() {
    DIRECTORY_FOR_TESTING=$WORKSPACE/$1

    #source ~/.profile
    cd $DIRECTORY_FOR_TESTING
    #npm prune
    #npm install
    #npm run test
}

function runTests() {
    DIRS_FOR_TEST=`getDirectoriesForTest`

    for DIR in $DIRS_FOR_TEST
        do
            runTestForDirectory $DIR
        done
}

runTests