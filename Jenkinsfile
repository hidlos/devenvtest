#!groovy

stage('run tests') {
    node ('nodejs') {
         runTests()
    }
}


def runTests() {
    echo(pwd())
    def rootPath = sh 'git diff --name-only $TRAVIS_COMMIT_RANGE'
    def rootPathStatus = sh returnStatus: true, script: 'git diff --name-only $TRAVIS_COMMIT_RANGE'
    echo(env())
    echo(rootPath)
    echo(rootStatus)
}