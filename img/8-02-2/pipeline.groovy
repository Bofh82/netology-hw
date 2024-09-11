pipeline {
    agent {
      label 'deploy'
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', changelog: false, credentialsId: 'a6a55dc4-3b23-47ba-b523-9e48530c5bc6', poll: false, url: 'https://github.com/Bofh82/sdvps-materials.git'
            }
        }
        stage('Test') {
            steps {
                sh '/usr/local/go/bin/go test .'
            }
        }
        stage('Build Docker Image') {
            steps {
                sh 'docker build .'
            }
        }
    }
}