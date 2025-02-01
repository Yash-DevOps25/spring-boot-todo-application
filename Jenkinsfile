pipeline {
    agent any
    environment {
        DOCKERHUB_CREDENTIALS = credentials('dockerhub-credentials')
    }
    stages {
        stage('Checkout') {
            steps {
                // Clone the repository from GitHub
                git branch: 'main', url: 'https://github.com/Yash-DevOps25/spring-boot-todo-application.git'
            }
        }
        stage('Build') {
            steps {
                // Use Maven to build the Spring Boot project
                sh 'mvn clean package'
            }
        }
        stage('Docker Build & Push') {
            steps {
                script {
                    // Build Docker image
                    sh 'docker build -t your-dockerhub-yashguj20/spring-boot-todo-app .'
                    
                    // Login to DockerHub and push the image
                    sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
                    sh 'docker push your-dockerhub-yashguj20/spring-boot-todo-app'
                }
            }
        }
        stage('Deploy') {
            steps {
                // Deploy the Docker container (example using Docker Compose)
                sh 'docker-compose up -d'
            }
        }
    }
}
