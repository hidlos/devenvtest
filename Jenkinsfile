#!groovy

stage('run tests') {
    node ('nodejs') {
        runTests()
    }
}

def runTests() {
    def rootPath = pwd()
    def commitedFiles = getCommitedFiles()
    echo('commitedFiles')
    echo(commitedFiles[0])
    def affectedDirs = getAffectedDirs(commitedFiles)
    echo('affectedDirs')
    echo(affectedDirs)

    //echo(sh (script: "bash scripts/runTests.sh '$nodeModuleDirectories' '$rootPath'", returnStdout: true))
}

def getCommitedFiles() {
    def commitRange = getCommitRange()
    def commitedFilesFromBash = sh (script: "git diff --name-only $commitRange", returnStdout: true)
    return commitedFilesFromBash.toString().split('\n')
}

def getCommitRange() {
    return "e17e329..4ffc20f"
}



def getAffectedDirs(commitedFiles) {
    def modulesDirs = getModulesDirs()
    echo('moduleDirs')
    echo(moduleDirs[0])
    //sh (script: "bash scripts/getAffectedDirs.sh $nodeModules $commitedFiles", returnStdout: true)
    return "some"
}

def getModulesDirs() {
    def moduleDirsFromBash = sh (script: "find . -name package.json -printf '%h '", returnStdout: true)
    return moduleDirsFromBash.toString().split(' ')
}