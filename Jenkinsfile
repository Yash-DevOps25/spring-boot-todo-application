pipeline {
    agent any

    environment {
        DOCKERHUB_CREDENTIALS = credentials('dockerhub-credentials') // Jenkins credentials ID for DockerHub
        DOCKER_IMAGE_NAME = 'yashguj20/spring-boot-todo-app' // DockerHub username/repo
    }

    stages {
        stage('Checkout') {
            steps {
                // Clone the GitHub repository
                git branch: 'main', url: 'https://github.com/Yash-DevOps25/spring-boot-todo-application.git'
            }
        }

        stage('Build') {
            steps {
                // Build the Spring Boot application using Maven
                sh 'mvn clean package -DskipTests'
            }
        }

        stage('Docker Build & Push') {
            steps {
                script {
                    // Login to DockerHub
                    sh "echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin"

                    // Build and push the Docker image using Docker Compose
                    sh 'docker-compose -f docker-compose.yml build'
                    sh 'docker-compose -f docker-compose.yml push'
                }
            }
        }

        stage('Deploy with Docker Compose') {
            steps {
                script {
                    // Stop and remove existing containers to prevent conflicts
                    sh 'docker-compose -f docker-compose.yml down'

                    // Deploy the application
                    sh 'docker-compose -f docker-compose.yml up -d'
                }
            }
        }
    }

    post {
        success {
            echo 'Pipeline executed successfully!'
        }
        failure {
            echo 'Pipeline failed. Check the logs for errors.'
        }
    }
}
