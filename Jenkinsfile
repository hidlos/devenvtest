#!groovy

stage('run tests') {
    node ('nodejs') {
         runTests()
    }
}


def runTests() {
    echo(pwd())
    sh (script: "TRAVIS_COMMIT_RANGE='e17e329..4ffc20f'", returnStdout: true)
    def TRAVIS_COMMIT_RANGE = "e17e329..4ffc20f"
    sh 'env'
    def rootPath = sh (script: "git diff --name-only $TRAVIS_COMMIT_RANGE", returnStdout: true)
    echo(rootPath)
}