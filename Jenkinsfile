pipeline {
    agent any

    tools {
        jdk 'JDK-24'
        maven 'Maven'
    }

    environment {
        IMAGE_NAME = "employee-management"
        CONTAINER_NAME = "employee-management-container"
    }

    stages {

        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build') {
            steps {
                bat 'mvn clean package'
            }
        }

        stage('Deploy to Nexus') {
            steps {
                bat 'mvn deploy -s settings.xml'
            }
        }

        stage('Build Docker Image') {
            steps {
                bat 'docker build -t %IMAGE_NAME% .'
            }
        }

        stage('Remove Old Container') {
            steps {
                bat '''
                docker stop %CONTAINER_NAME% 2>nul
                docker rm %CONTAINER_NAME% 2>nul
                exit /b 0
                '''
            }
        }

        stage('Run Docker Container') {
            steps {
                bat 'docker run -d --name %CONTAINER_NAME% -p 8085:8085 %IMAGE_NAME%'
            }
        }
    }

    post {
        success {
            echo '========================================='
            echo 'BUILD SUCCESSFUL'
            echo 'Application URL: http://localhost:8085'
            echo '========================================='
        }

        failure {
            echo '========================================='
            echo 'BUILD FAILED'
            echo 'Check Jenkins Console Output'
            echo '========================================='
        }
    }
}
