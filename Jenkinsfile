#!groovy

stage('checkout') {
    node ('nodejs') {
            sh 'pwd'
            sh 'ls'
            sh (script: "cd /home/jenkins/workspace/pipe/ && rm -rf * && cp -r -a /home/jenkins/jobs/pipe/workspace@script/* /home/jenkins/workspace/pipe/ && ls && pwd", returnStdout: true)
            sh (script: "cd /home/jenkins/workspace/ && rm -rf pipe && ln -s /home/jenkins_home/workspaces/pipe pipe", returnStdout: true)
    }
}

stage('run tests') {
    node ('nodejs') {
        sh 'sleep 10'
        sh 'cat Jenkinsfile'
        sh 'pwd'
        sh 'ls'
        sh 'echo $WORKSPACE'
        runTests()
    }
}

stage('build images') {
    node ('nodejs') {
        echo('zde')
    }
}



def runTests() {
    def rootPath = pwd()
    def affectedDirs = getAffectedDirs()

    for (dir in affectedDirs) {
        runTestForDirectory(dir, rootPath)
    }
}

def getCommitedFiles() {
    def commitRange = getCommitRange()
    def commitedFilesFromBash = sh (script: "git diff --name-only $commitRange", returnStdout: true)
    return commitedFilesFromBash.toString()
}

def getCommitRange() {
    return "e17e329..4ffc20f"
}

def getAffectedDirs() {
    def commitedFiles = getCommitedFiles()
    def moduleDirs = getModulesDirs()
    def affectedDirs = []

    for (dir in moduleDirs) {
        currentDir = dir.substring(2,dir.length())
        if (commitedFiles.contains(currentDir)) {
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