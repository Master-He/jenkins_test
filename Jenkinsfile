#!/usr/bin/env groovy

pipeline { 
    agent any 
    stages {
        stage('Build') { 
            steps {
                sh 'echo >> ./.env'
                sh 'echo "#BUILD_ID" >> ./.env'
                sh 'echo "BUILD_ID=${BUILD_ID}" >> ./.env'
                sh './build_deployment_package.sh ./hyperminer_v1.6_all_${BUILD_ID}.tar.gz'
            }
        }

    }
}
