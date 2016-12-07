#!groovy

stage('build workspace') {
    node ('nodejs') {
        sh (script: "rm -rf /home/jenkins/workspace/pipe && cp -r -a /home/jenkins/jobs/pipe/workspace@script /home/jenkins/workspace/pipe", returnStdout: true)
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

def runTests() {
    def directoriesForTest = getDirectoriesForTest()
    def rootPath = pwd()

    for (dir in directoriesForTest) {
        runTestForDirectory(dir, rootPath)
    }
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
    echo(affectedFilesFromBash)
    return affectedFilesFromBash
}

def getCommitRange() {

    node ('master') {
	    def result = sh (script: "curl GET localhost:8080/job/pipe/lastSuccessfulBuild/api/xml | xmllint --xpath '//workflowRun/action[@_class=\"hudson.plugins.git.util.BuildData\"]/lastBuiltRevision/SHA1/text()' -", returnStdout: true)
	    echo(result)
    }
    sh 'ls'
    def result2 = sh (script: "'source ./scripts/scripts.sh' && getLastSuccessfulBuildHash", returnStdout: true)
    echo(result2)
    def gitCommit = sh(returnStdout: true, script: 'git rev-parse HEAD').trim()
    echo(gitCommit)

    return "e17e329..4ffc20f"
}

def runTestForDirectory(dir, rootPath) {
    echo(sh (script: "cd $rootPath/$dir && npm prune && npm install && npm run test:single", returnStdout: true))
}

def buildImages() {
    def directoriesForBuildImages = getDirectoriesForBuildImages()
    def rootPath = pwd()

    for (dir in directoriesForBuildImages) {
        //buildImage(dir, rootPath)
    }
}

def getDirectoriesForBuildImages() {
    def appDirectories = getAppDirectories()
    return getAffectedDirs(appDirectories)
}

def getAppDirectories() {
    return sh (script: "find . -name Dockerfile -printf '%h '", returnStdout: true).toString().split(' ')
}

def buildImage(dir, rootPath) {
    sh (script: "bash ./scripts/buildImage.sh '$dir' '$rootPath'", returnStdout: true)
}