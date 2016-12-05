#!groovy

stage('checkout') {
    node ('nodejs') {
        sh (script: "rm -rf /home/jenkins/workspace/pipe && cp -r -a /home/jenkins/jobs/pipe/workspace@script /home/jenkins/workspace/pipe", returnStdout: true)
            def gitCommit = sh(returnStdout: true, script: 'git rev-parse HEAD').trim()
            echo(gitCommit)
            def gitShow = sh(script: "git show -p origin/master", returnStdout: true)
            echo(gitShow)
            echo "currentBuild.buildVariables()"
            echo "zacatek"
            sh "env"
            echo "konec"
            for (set in currentBuild.changeSets) {
                echo(set.toString())
                echo " \n"
            }
    }
}

stage('run tests') {
    node ('nodejs') {
        runTests()
    }
}

stage('build images') {
    node ('nodejs') {
        def directoriesForBuild = getDirectoriesForBuild(getCommittedFiles())
        def rootPath = pwd()
        buildImages(directoriesForBuild, rootPath)
    }
}



def runTests() {
    def rootPath = pwd()
    def affectedDirs = getAffectedDirs(getModulesDirs(), getCommittedFiles())

    for (dir in affectedDirs) {
        runTestForDirectory(dir, rootPath)
    }
}

def getCommittedFiles() {
    def commitRange = getCommitRange()
    def committedFilesFromBash = sh (script: "git diff --name-only $commitRange", returnStdout: true)
    return committedFilesFromBash.toString()
}

def getCommitRange() {
    return "e17e329..4ffc20f"
}

def getAffectedDirs(dirs, committedFiles) {
    def affectedDirs = []

    for (dir in dirs) {
        currentDir = dir.substring(2,dir.length())
        if (committedFiles.contains(currentDir)) {
            affectedDirs.push(currentDir)
        }
    }
    return affectedDirs
}

def getModulesDirs() {
    def moduleDirsFromBash = sh (script: "find . -name package.json -printf '%h '", returnStdout: true)
    return moduleDirsFromBash.toString().split(' ')
}

def runTestForDirectory(dir, rootPath) {
    //echo(sh (script: "cd $rootPath/$dir && ls", returnStdout: true))
    echo(sh (script: "cd $rootPath/$dir && npm prune && npm install && npm run test:single", returnStdout: true))
    //sh (script: "echo \"`bash scripts/runTests.sh apps/app1 $rootPath`\"", returnStdout: true)
}


def getDirectoriesForBuild(committedFiles)
{
    def dockerImageDirectories = sh (script: "find . -name Dockerfile -printf '%h '", returnStdout: true)
    return getAffectedDirs(dockerImageDirectories.toString().split(' '), committedFiles)
}

def buildImages(dockerImageDirectories, rootPath)
{
    for (dir in dockerImageDirectories)
    {
        sh (script: "bash ./scripts/buildImage.sh '$dir' '$rootPath'", returnStdout: true)
    }
}