pipeline {
    agent any

    environment {
        DEV_IMAGE = 'mydockerimage31/dev:latest'
        PROD_IMAGE = 'mydockerimage31/prod:latest'
    }

    stages {

        stage('Clone Repo') {
            steps {
                git branch: 'dev', url: 'https://github.com/mygitcode31/devops-build.git'
            }
        }

        stage('Build Image') {
            steps {
                sh 'docker build -t $DEV_IMAGE .'
            }
        }

        stage('Docker Login') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub-cred', usernameVariable: 'USER', passwordVariable: 'PASS')]) {
                    sh 'echo $PASS | docker login -u $USER --password-stdin'
                }
            }
        }

        stage('Push Dev Image') {
            when {
                branch 'dev'
            }
            steps {
                sh 'docker push $DEV_IMAGE'
            }
        }

        stage('Push Prod Image') {
            when {
                branch 'main'
            }
            steps {
                sh '''
                docker tag $DEV_IMAGE $PROD_IMAGE
                docker push $PROD_IMAGE
                '''
            }
        }

        stage('Deploy') {
            steps {
                sh '''
                docker stop react-app || true
                docker rm react-app || true
                docker run -d -p 80:80 --name react-app $DEV_IMAGE
                '''
            }
        }
    }
}
