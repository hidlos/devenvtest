#!/usr/bin/env bash

source ./getAffectedDirs.sh

function getAppDirectories() {
    echo find . -name Dockerfile -printf '%h\n'
}

function getDirectoriesForBuildImages() {
    APP_DIRS=`getAppDirectories`
    echo `getAffectedDirs $APP_DIRS`
}

function buildImage() {
    ../scripts/buildImage.sh $1 $WORKSPACE
}

function buildImages() {
    DIRS_FOR_BUILD_IMAGES=`getDirectoriesForBuildImages`

    for DIR in $DIRS_FOR_BUILD_IMAGES
    do
        buildImage $DIR
    done
}

buildImages




