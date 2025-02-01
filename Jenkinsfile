pipeline {
    agent any

    environment {
        DOCKERHUB_CREDENTIALS = credentials('dockerhub-credentials') // Jenkins credentials ID for DockerHub
        DOCKER_IMAGE_NAME = 'yashguj20/spring-boot-todo-app' // Replace with your DockerHub username/repo
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
                    // Build the Docker image
                    sh 'docker build -t $DOCKER_IMAGE_NAME .'

                    // Login to DockerHub
                    sh "echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin"

                    // Push the Docker image to DockerHub
                    sh 'docker push $DOCKER_IMAGE_NAME'
                }
            }
        }

        stage('Deploy') {
            steps {
                script {
                    // Deploy using Docker (Optional)
                    // Here, it assumes you're using Docker Compose or just running the container directly
                    sh 'docker run -d -p 8080:8080 $DOCKER_IMAGE_NAME'
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
