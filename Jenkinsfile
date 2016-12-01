#!groovy

stage('run tests') {
    node ('nodejs') {
         runTests()
    }
}


def runTests() {
    def rootPath = pwd()
    def commitRange = "e17e329..4ffc20f"
    nodeModuleDirectories = getAffectedNodeModuleDirs(commitRange)
    echo(nodeModuleDirectories)

    echo(sh (script: "bash scripts/runTests.sh '$nodeModuleDirectories' '$rootPath'", returnStdout: true))

}

def getAffectedNodeModuleDirs(commitRange) {
    def commitedFiles = sh (script: "git diff --name-only $commitRange", returnStdout: true)
    sh (script: "bash scripts/getAffectedNodeModuleDirs.sh '$commitedFiles'", returnStdout: true)
}