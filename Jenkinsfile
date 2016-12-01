#!groovy

stage('run tests') {
    node ('nodejs') {
        runTests()
    }
}

def runTests() {
    def rootPath = pwd()
    def affectedDirs = getAffectedDirs()

    for (dir in affectedDirs) {
        runTestForDirectory(dir, rootPath)
    }
}

def getCommitedFiles() {
    def commitRange = getCommitRange()
    def commitedFilesFromBash = sh (script: "git diff --name-only $commitRange", returnStdout: true)
    return commitedFilesFromBash.toString()
}

def getCommitRange() {
    return "e17e329..4ffc20f"
}

def getAffectedDirs() {
    def commitedFiles = getCommitedFiles()
    def moduleDirs = getModulesDirs()
    def affectedDirs = []

    for (dir in moduleDirs) {
        currentDir = dir.substring(2,dir.length())
        if (commitedFiles.contains(currentDir)) {
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
    sh (script: "cd && ls", returnStdout: true)
    sh (script: "echo \"`bash scripts/runTests.sh apps/app1 $rootPath`\"", returnStdout: true)
    sh 'ls'
}