#!groovy

stage('run tests') {
    node ('nodejs') {
         runTests()
    }
}


def runTests() {
    def rootPath = pwd()
    def TRAVIS_COMMIT_RANGE = "e17e329..4ffc20f"
    def commitedFiles = sh (script: "git diff --name-only $TRAVIS_COMMIT_RANGE", returnStdout: true)

    nodeModuleDirectories = sh (script: "bash scripts/getAffectedNodeModuleDirs.sh '$commitedFiles'", returnStdout: true)
    echo(nodeModuleDirectories)

    echo(sh (script: "bash scripts/runTests.sh '$nodeModuleDirectories' '$rootPath'", returnStdout: true))

}