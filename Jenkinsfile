#!groovy

stage('build workspace') {
    node ('nodejs') {
        sh (script: "rm -rf $WORKSPACE && cp -r -a $SCRIPT_HOME $WORKSPACE", echoStdout: true)
    }
}

stage('run tests') {
    node ('nodejs') {
        echo(sh (script: "bash ./jenkins_scripts/runTests.sh", echoStdout: true))
        //runTests()
    }
}

stage('build images') {
    node ('nodejs') {
        //buildImages()
    }
}

def runTests() {
    def directoriesForTest = getDirectoriesForTest()

    for (dir in directoriesForTest) {
        runTestForDirectory(dir)
    }
}

def getDirectoriesForTest() {
    def modulesDirectories = getModuleDirectories()
    echo getAffectedDirs(modulesDirectories)
}

def getModuleDirectories() {
    def moduleDirsFromBash = sh (script: "find . -name package.json -printf '%h '", echoStdout: true)
    echo moduleDirsFromBash.toString().split(' ')
}

def getAffectedDirs(dirs) {
    def affectedFiles = getAffectedFilesFromCommit()
    def affectedDirs = []

    for (dir in dirs) {
        currentDir = dir.substring(2,dir.length())
        if (affectedFiles.contains(currentDir)) {
            echo(currentDir)
            affectedDirs.push(currentDir)
        }
    }

    echo affectedDirs
}

def getAffectedFilesFromCommit() {
    def commitRange = getCommitRange()
    def affectedFilesFromBash = sh (script: "git diff --name-only $commitRange", echoStdout: true).toString()
    echo affectedFilesFromBash
}

def getCommitRange() {
    def lastSuccessfulBuildHash
    def actualCommit = sh(echoStdout: true, script: 'git rev-parse HEAD').trim()

    def ch = changeSets()
    echo(ch)
    node ('master') {
        lastSuccessfulBuildHash = getLastSuccessfulBuildHash()
    }
    //echo ch
    echo '12343e6fc29bd729b290e01a6a799a33914513df..7397e92b901e669b543efae7605dca2662ce50b9'
    echo lastSuccessfulBuildHash + '..' + actualCommit
}

@NonCPS
def changeSets() {
    for (changeSetList in currentBuild.changeSets) {
        def firstCommit = changeSetList.first().getCommitId()
        echo(changeSetList.first().getAffectedPaths().toString())

        def secondCommit = changeSetList.last().getCommitId()
        echo("ARSI result: ${firstCommit}..${secondCommit}")
        echo "${firstCommit}..${secondCommit}"
    }
}

def runTestForDirectory(dir) {
    echo(sh (script: "cd $WORKSPACE/$dir && npm prune && npm install && npm run test:single", echoStdout: true))
}

def getLastSuccessfulBuildHash() {
    def url = "localhost:8080/job/pipe/lastSuccessfulBuild/api/xml"
    def xml_path = '//workflowRun/action[@_class=\"hudson.plugins.git.util.BuildData\"]/lastBuiltRevision/SHA1/text()'
    echo sh (script: "curl -G $url | xmllint --xpath '$xml_path' -", echoStdout: true)
}

def buildImages() {
    def directoriesForBuildImages = getDirectoriesForBuildImages()

    for (dir in directoriesForBuildImages) {
        buildImage(dir)
    }
}

def getDirectoriesForBuildImages() {
    def appDirectories = getAppDirectories()
    echo getAffectedDirs(appDirectories)
}

def getAppDirectories() {
    echo sh (script: "find . -name Dockerfile -printf '%h '", echoStdout: true).toString().split(' ')
}

def buildImage(dir) {
    echo(sh (script: "bash ./scripts/buildImage.sh '$dir' '$WORKSPACE'", echoStdout: true))
}