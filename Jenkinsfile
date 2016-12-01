#!groovy

stage('run tests') {
    node ('nodejs') {
        runTests()
    }
}

def runTests() {
    def rootPath = pwd()
    def commitedFiles = getCommitedFiles()
    nodeModuleDirectories = getAffectedNodeModuleDirs(commitedFiles)
    echo(nodeModuleDirectories)
    //echo(sh (script: "bash scripts/runTests.sh '$nodeModuleDirectories' '$rootPath'", returnStdout: true))
}

def getCommitedFiles() {
    def commitRange = getCommitRange()
    def commitedFilesFromBash = sh (script: "git diff --name-only $commitRange", returnStdout: true)
    def commitedFiles = commitedFilesFromBash.toString().split('\n')
    getAffectedNodeModuleDirs(commitedFiles)
}

def getCommitRange() {
    return "e17e329..4ffc20f"
}

def getAffectedNodeModuleDirs(commitedFiles) {
    def nodeModules = getNodeModules()
    echo(nodeModules[1])
    echo(commitedFiles[0])
    getAffectedDirs(nodeModules, commitedFiles)
}

def getNodeModules() {
    def nodeModulesFromBash = sh (script: "find . -name package.json -printf '%h '", returnStdout: true)
    return nodeModulesFromBash.toString().split(' ')
}

def getAffectedDirs(nodeModules, commitedFiles) {
    //sh (script: "scripts/getAffectedDirs.sh $nodeModules $commitedFiles", returnStdout: true)
    return "some"
}