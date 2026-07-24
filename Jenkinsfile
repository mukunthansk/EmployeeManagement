pipeline {
    agent any

    tools {
        jdk 'JDK-24'
        maven 'Maven'
    }

    stages {

        stage('Checkout') {
            steps {
                git 'https://github.com/<your-username>/EmployeeManagement.git'
            }
        }

        stage('Build') {
            steps {
                bat 'mvn clean package'
            }
        }

        stage('Deploy to Nexus') {
            steps {
                bat 'mvn deploy'
            }
        }

        stage('Build Docker Image') {
            steps {
                bat 'docker build -t employee-management:1.0 .'
            }
        }

        stage('Run Docker Container') {
            steps {
                bat '''
                docker rm -f employee-management || exit 0
                docker run -d --name employee-management -p 8085:8085 employee-management:1.0
                '''
            }
        }
    }
}