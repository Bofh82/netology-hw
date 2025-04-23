pipeline {
    agent {
      label 'deploy'
    }

    environment {
        NEXUS_URL = 'http://192.168.137.121:8081'
        NEXUS_CREDENTIALS_ID = 'nexus-credentials-id'
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
        stage('Build Binary') {
            steps {
                sh '/usr/local/go/bin/go build -a -installsuffix nocgo -o myapp .'
            }
        }
        stage('Upload to Nexus') {
            steps {
                script {
                    def nexusUrl = "http://192.168.137.121:8081/repository/netology/"
                    withCredentials([usernamePassword(credentialsId: NEXUS_CREDENTIALS_ID, passwordVariable: 'NEXUS_PASSWORD', usernameVariable: 'NEXUS_USERNAME')]) {
                        sh """
                            curl -u ${NEXUS_USERNAME}:${NEXUS_PASSWORD} --upload-file myapp ${nexusUrl}
                        """
                    }
                }
            }
        }        
    }
}