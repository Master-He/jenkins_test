pipeline {
    agent any
    stages {
        stage('test') {
            steps {
                sh 'echo *****=====whoami=====*****'
                sh 'whoami'
                sh 'echo *****=====prepare env=====*****'
                sh 'echo ${USER_TYPE}'
            }
        }
        stage('build') {
            steps {
                sh './build.sh'
            }
        }
        stage('deploy') {
            steps {
                sh './run.sh'
            }
        }
    }
}
