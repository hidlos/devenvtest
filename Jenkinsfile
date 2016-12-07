#!groovy

stage('build workspace') {
    node ('nodejs') {
        sh (script: "rm -rf /home/jenkins/workspace/pipe && cp -r -a /home/jenkins/jobs/pipe/workspace@script /home/jenkins/workspace/pipe", returnStdout: true)
    }
}

stage('set variables') {
    node ('nodejs') {
        setVariables()
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

def setVariables() {
    def rootPath = pwd()
}

def getAffectedFilesFromCommit() {
    def commitRange = getCommitRange()
    def affectedFilesFromBash = sh (script: "git diff --name-only $commitRange", returnStdout: true)
    echo(affectedFilesFromBash.toString())
    return affectedFilesFromBash.toString()
}

def getCommitRange() {
    return "5db9c43..c6bfc45"
}

def runTests() {
    def directoriesForTest = getDirectoriesForTest()
    def rootPath = pwd()

    for (dir in directoriesForTest) {
        runTestForDirectory(dir, rootPath)
    }
}

def getDirectoriesForTest() {
    def modulesDirectories = getModuleDirectories()
    return getAffectedDirs(modulesDirectories)
}

def getAffectedDirs(dirs) {
    def affectedFiles = getAffectedFilesFromCommit()
    def affectedDirs = []

    for (dir in dirs) {
        currentDir = dir.substring(2,dir.length())
        if (affectedFiles.contains(currentDir)) {
            affectedDirs.push(currentDir)
        }
    }
    return affectedDirs
}

def getModuleDirectories() {
    def moduleDirsFromBash = sh (script: "find . -name package.json -printf '%h '", returnStdout: true)
    return moduleDirsFromBash.toString().split(' ')
}

def runTestForDirectory(dir, rootPath) {
    //echo(sh (script: "cd $rootPath/$dir && ls", returnStdout: true))
    echo(sh (script: "cd $rootPath/$dir && npm prune && npm install && npm run test:single", returnStdout: true))
    //sh (script: "echo \"`bash scripts/runTests.sh apps/app1 $rootPath`\"", returnStdout: true)
}

def getDirectoriesForBuildImages() {
    def appDirectories = getAppDirectories()
    return getAffectedDirs(appDirectories)
}

def getAppDirectories() {
    return sh (script: "find . -name Dockerfile -printf '%h '", returnStdout: true).toString().split(' ')
}

def buildImages(rootPath) {
    def directoriesForBuildImages = getDirectoriesForBuildImages()
    def rootPath = pwd()

    for (dir in directoriesForBuildImages) {
        sh (script: "bash ./scripts/buildImage.sh '$dir' '$rootPath'", returnStdout: true)
    }
}
