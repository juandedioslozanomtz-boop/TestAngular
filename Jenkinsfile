pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps { checkout scm }
        }

        stage('Install & Build Angular') {
            steps {
                sh 'npm install'
                sh 'npm run build'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t testangular .'
            }
        }

        stage('Deploy Angular Container') {
            steps {
                sh '''
                docker stop testangular || true
                docker rm testangular || true
                docker run -d --name testangular -p 80:80 testangular
                '''
            }
        }
    }
}
