#!groovy

stage('build workspace') {
    node ('nodejs') {
        sh (script: "rm -rf $WORKSPACE && cp -r -a $SCRIPT_HOME $WORKSPACE", returnStdout: true)
    }
}

stage('run tests') {
    node ('nodejs') {
        runTests()
    }
}

stage('build images') {
    node ('nodejs') {
        buildImages()
    }
}

@NonCPS
def runTests() {
    def directoriesForTest = getDirectoriesForTest()
    directoriesForTest.each { runTestForDirectory }

    //for (dir in directoriesForTest) {
    //    runTestForDirectory(dir)
    //}
}

def getDirectoriesForTest() {
    def modulesDirectories = getModuleDirectories()
    return getAffectedDirs(modulesDirectories)
}

def getModuleDirectories() {
    def moduleDirsFromBash = sh (script: "find . -name package.json -printf '%h '", returnStdout: true)
    return moduleDirsFromBash.toString().split(' ')
}

def getAffectedDirs(dirs) {
    def affectedFiles = getAffectedFilesFromCommit()
    def affectedDirs = []

    for (dir in dirs) {
        currentDir = dir.substring(2,dir.length())
        if (affectedFiles.contains(currentDir)) {
            affectedDirs.push(currentDir)
        }
    }

    return affectedDirs
}

def getAffectedFilesFromCommit() {
    def commitRange = getCommitRange()
    def affectedFilesFromBash = sh (script: "git diff --name-only $commitRange", returnStdout: true).toString()
    return affectedFilesFromBash
}

def getCommitRange() {
    def lastSuccessfulBuildHash
    def actualCommit = sh(returnStdout: true, script: 'git rev-parse HEAD').trim()

    node ('master') {
        lastSuccessfulBuildHash = getLastSuccessfulBuildHash()
    }
    return lastSuccessfulBuildHash + '..' + actualCommit
}

def runTestForDirectory(dir) {
    echo(sh (script: "cd $WORKSPACE/$dir && npm prune && npm install && npm run test:single", returnStdout: true))
}

def getLastSuccessfulBuildHash() {
    def url = "localhost:8080/job/pipe/lastSuccessfulBuild/api/xml"
    def xml_path = '//workflowRun/action[@_class=\"hudson.plugins.git.util.BuildData\"]/lastBuiltRevision/SHA1/text()'
    return sh (script: "curl -G $url | xmllint --xpath '$xml_path' -", returnStdout: true)
}

def buildImages() {
    def directoriesForBuildImages = getDirectoriesForBuildImages()

    for (dir in directoriesForBuildImages) {
        //buildImage(dir)
    }
}

def getDirectoriesForBuildImages() {
    def appDirectories = getAppDirectories()
    return getAffectedDirs(appDirectories)
}

def getAppDirectories() {
    return sh (script: "find . -name Dockerfile -printf '%h '", returnStdout: true).toString().split(' ')
}

def buildImage(dir) {
    sh (script: "bash ./scripts/buildImage.sh '$dir' '$WORKSPACE'", returnStdout: true)
}