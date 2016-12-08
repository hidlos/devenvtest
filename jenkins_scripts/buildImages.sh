#!/usr/bin/env bash

source $WORKSPACE/jenkins_scripts/getAffectedDirs.sh

function getAppDirectories() {
    echo find . -name Dockerfile -printf '%h\n'
}

function getDirectoriesForBuildImages() {
    APP_DIRS=`getAppDirectories`
    $APP_DIRS
    echo `getAffectedDirs '$APP_DIRS'`
}

function buildImage() {
    ./$WORKSPACE/jenkins_scripts/buildImage.sh $1
}

function buildImages() {
    DIRS_FOR_BUILD_IMAGES=`getDirectoriesForBuildImages`

    for DIR in $DIRS_FOR_BUILD_IMAGES
    do
        buildImage $DIR
    done
}

buildImages




