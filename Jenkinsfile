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
    echo(sh (script: "bash scripts/runTests.sh '$nodeModuleDirectories' '$rootPath'", returnStdout: true))
}

def getCommitedFiles() {
    def commitRange = getCommitRange()
    def commitedFiles = sh (script: "git diff --name-only $commitRange", returnStdout: true)
    getAffectedNodeModuleDirs(commitedFiles)
}

def getCommitRange() {
    return "e17e329..4ffc20f"
}

def getAffectedNodeModuleDirs(commitedFiles) {
    def nodeModules = sh (script: "bash scripts/getNodeModules.sh", returnStdout: true)
    echo('x')
    def x = nodeModules.toString().split(' ')
    echo(x[0])
    echo(commitedFiles)
    getAffectedDirs(nodeModules, commitedFiles)
}

def getAffectedDirs(nodeModules, commitedFiles) {
    sh (script: "scripts/getAffectedDirs.sh $nodeModules $commitedFiles", returnStdout: true)
}