#!groovy

stage('build workspace') {
    node ('nodejs') {
        sh (script: "rm -rf /home/jenkins/workspace/pipe && cp -r -a /home/jenkins/jobs/pipe/workspace@script /home/jenkins/workspace/pipe", returnStdout: true)
    }
}

stage('setup variables') {
    node ('nodejs') {
        def rootPath = pwd()
        def commitedFiles = getCommittedFiles()
    }
}

stage('run tests') {
    node ('nodejs') {
        runTests()
    }
}

stage('build images') {
    node ('nodejs') {
        buildImages(rootPath)
    }
}

def getCommittedFiles() {
    def commitRange = getCommitRange()
    def committedFilesFromBash = sh (script: "git diff --name-only $commitRange", returnStdout: true)
    echo(committedFilesFromBash.toString())
    return committedFilesFromBash.toString()
}

def getCommitRange() {
    return "5db9c43..c6bfc45"
}

def runTests() {
    def affectedDirs = getAffectedDirs(getModulesDirs(), commitedFiles)

    for (dir in affectedDirs) {
        runTestForDirectory(dir, rootPath)
    }
}

def getAffectedDirs(dirs, committedFiles) {
    def affectedDirs = []

    for (dir in dirs) {
        currentDir = dir.substring(2,dir.length())
        if (committedFiles.contains(currentDir)) {
            affectedDirs.push(currentDir)
        }
    }
    return affectedDirs
}

def getModulesDirs() {
    def moduleDirsFromBash = sh (script: "find . -name package.json -printf '%h '", returnStdout: true)
    return moduleDirsFromBash.toString().split(' ')
}

def runTestForDirectory(dir, rootPath) {
    //echo(sh (script: "cd $rootPath/$dir && ls", returnStdout: true))
    echo(sh (script: "cd $rootPath/$dir && npm prune && npm install && npm run test:single", returnStdout: true))
    //sh (script: "echo \"`bash scripts/runTests.sh apps/app1 $rootPath`\"", returnStdout: true)
}

def getDirectoriesForBuild(committedFiles) {
    def directoriesForBuildImages = sh (script: "find . -name Dockerfile -printf '%h '", returnStdout: true)
    return getAffectedDirs(directoriesForBuildImages.toString().split(' '), committedFiles)
}

def buildImages(rootPath) {
    def directoriesForBuildImages = getDirectoriesForBuild(commitedFiles)

    for (dir in directoriesForBuildImages) {
        sh (script: "bash ./scripts/buildImage.sh '$dir' '$rootPath'", returnStdout: true)
    }
}
