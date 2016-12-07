#!groovy

stage('build workspace') {
    node ('nodejs') {
        sh (script: "rm -rf /home/jenkins/workspace/pipe && cp -r -a /home/jenkins/jobs/pipe/workspace@script /home/jenkins/workspace/pipe", returnStdout: true)
    }
}

stage('run tests') {
    node ('nodejs') {
        runTests()
    }
}

stage('build images') {
    node ('nodejs') {
        buildImages()
    }
}

def getAffectedFilesFromCommit() {
    def commitRange = getCommitRange()
    def affectedFilesFromBash = sh (script: "git diff --name-only $commitRange", returnStdout: true)
    echo(affectedFilesFromBash.toString())
    return affectedFilesFromBash.toString()
}

def getCommitRange() {
    return "e17e329..4ffc20f"
}

def runTests() {
    def directoriesForTest = getDirectoriesForTest()
    runFnInDirectories(directoriesForTest, 'runTestForDirectory')

    //def rootPath = pwd()

    //for (dir in directoriesForTest) {
    //    runTestForDirectory(dir, rootPath)
    //}
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
    echo(sh (script: "cd $rootPath/$dir && npm prune && npm install && npm run test:single", returnStdout: true))
}

def getDirectoriesForBuildImages() {
    def appDirectories = getAppDirectories()
    return getAffectedDirs(appDirectories)
}

def getAppDirectories() {
    return sh (script: "find . -name Dockerfile -printf '%h '", returnStdout: true).toString().split(' ')
}

def buildImages() {
    def directoriesForBuildImages = getDirectoriesForBuildImages()
    def rootPath = pwd()

    for (dir in directoriesForBuildImages) {
        //buildImage(dir, rootPath)
    }
}

def buildImage(dir, rootPath) {
    sh (script: "bash ./scripts/buildImage.sh '$dir' '$rootPath'", returnStdout: true)
}

def runFnInDirectories(directories, fn) {
    def rootPath = pwd()

    for (dir in directories) {
        fn(dir, rootPath)
    }
}
