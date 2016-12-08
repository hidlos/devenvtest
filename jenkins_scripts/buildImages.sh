#!/usr/bin/env bash

source $WORKSPACE/jenkins_scripts/getAffectedDirs.sh

function getAppDirectories() {
    ls
    echo find . -name Dockerfile -printf '%h\n'
}

function getDirectoriesForBuildImages() {
    APP_DIRS=`getAppDirectories`
    echo `getAffectedDirs $APP_DIRS`
}

function buildImage() {
    ls -alF
    $WORKSPACE/jenkins_scripts/buildImage.sh $1
}

function buildImages() {
    DIRS_FOR_BUILD_IMAGES=`getDirectoriesForBuildImages`

    for DIR in $DIRS_FOR_BUILD_IMAGES
    do
        buildImage $DIR
    done
}

buildImages




