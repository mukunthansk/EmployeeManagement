pipeline {
    agent any

    tools {
        jdk 'JDK-24'
        maven 'Maven'
    }

    environment {
        IMAGE_NAME = "employee-management:1.1"
        CONTAINER_NAME = "employee-management"
    }

    stages {

        stage('Checkout') {
            steps {
                git branch: 'main',
                    url: 'https://github.com/mukunthansk/EmployeeManagement.git',
                    credentialsId: 'mukunthansk'
            }
        }

        stage('Build') {
            steps {
                bat 'mvn clean package'
            }
        }

        stage('Deploy to Nexus') {
            steps {
                bat 'mvn deploy --settings settings.xml'
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
                docker stop %CONTAINER_NAME% || exit 0
                docker rm %CONTAINER_NAME% || exit 0
                '''
            }
        }

        stage('Run Docker Container') {
            steps {
                bat 'docker run -d --name %CONTAINER_NAME% -p 8085:8085 %IMAGE_NAME%'
            }
        }
    }
}