#!/usr/bin/env bash


function getLastSuccessfulBuildHash() {
    XML_URL=http://test-jenkins.billboard.intra:8080/job/$JOB_NAME/lastSuccessfulBuild/api/xml
    XML_PATH='//workflowRun/action[@_class=\"hudson.plugins.git.util.BuildData\"]/lastBuiltRevision/SHA1/text()'
    echo `curl -G $XML_URL | xmllint --xpath '$XML_PATH' -`
}


function getCommitRange() {
    ACTUAL_COMMIT=`git rev-parse HEAD`

    #IF WE USE AGENTS, THIS HAS TO BE RUN ON MASTER
    LAST_SUCCESSFUL_BUILD_HASH=`getLastSuccessfulBuildHash`
    echo 12343e6fc29bd729b290e01a6a799a33914513df..7397e92b901e669b543efae7605dca2662ce50b9
    #echo 47e53f4256ebea159bf03664b5b9f13db9f367ae..bd3ea1c829b65c18ffd1aca333976483fbf22597
    #echo $LAST_SUCCESSFUL_BUILD_HASH..$ACTUAL_COMMIT
}

function getAffectedFilesFromCommit() {
    COMMIT_RANGE=`getCommitRange`
    echo `git diff --name-only $COMMIT_RANGE`
}

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

function getModuleDirectories() {
    echo `find . -name package.json -printf '%h\n'`
}

function getDirectoriesForTest() {
    MODULES_DIRS=`getModuleDirectories`
    echo `getAffectedDirs $MODULES_DIRS`
}

function runTestForDirectory() {
    DIRECTORY_FOR_TESTING=$WORKSPACE/$1

    source ~/.profile
    cd $DIRECTORY_FOR_TESTING
    npm prune
    npm install
    npm run test
}

function runTests() {
    DIRS_FOR_TEST=`getDirectoriesForTest`

    for DIR in $DIRS_FOR_TEST
    do
      `runTestForDirectory $DIR`
    done
}

runTests