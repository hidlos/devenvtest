#!groovy

node ('pullFromGit') {
    stage 'pulling from git'
    checkout([$class: 'GitSCM', branches: [[name: '*/master']],
        userRemoteConfigs: [[url: 'git@github.com:sensensi/devenvtest.git'], [credentialsId: 'd3ecfe03-0c16-45d2-b272-e0fd1667bc0f']]])

}
