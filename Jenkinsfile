#!groovy

stage('run tests') {
    node ('nodejs') {
         runTests()
    }
}


def runTests() {
    echo(pwd())
    def rootPath = sh (script: 'git diff --name-only $TRAVIS_COMMIT_RANGE', returnStdout: true)
    echo(rootPath)
}