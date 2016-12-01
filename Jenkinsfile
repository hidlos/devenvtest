#!groovy

stage('run tests') {
    node ('nodejs') {
         runTests()
    }
}


def runTests() {
    echo(pwd())
    def rootPath = pwd()
    def TRAVIS_COMMIT_RANGE = "e17e329..4ffc20f"
    sh 'env'
    def commitedFiles = sh (script: "git diff --name-only $TRAVIS_COMMIT_RANGE", returnStdout: true)
    echo(rootPath)

    nodeModuleDirectories = sh (script: "bash scripts/getAffectedNodeModuleDirs.sh '$commitedFiles'", returnStdout: true)
    echo(nodeModuleDirectories)
}