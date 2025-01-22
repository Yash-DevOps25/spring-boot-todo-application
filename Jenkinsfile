pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'yash/spring-boot-todo-app'
        REGISTRY = 'docker.io'
        GIT_URL = 'https://github.com/Yash-DevOps25/spring-boot-todo-application.git'
    }

    tools {
        // Specify Maven version
        maven 'Maven-3.8.7'
    }

    stages {
        stage('Checkout SCM') {
            steps {
                git url: "$GIT_URL", branch: 'main'
            }
        }

        stage('Build') {
            steps {
                script {
                    // Clean and install using Maven
                    sh 'mvn clean install'
                }
            }
        }

        stage('Test') {
            steps {
                script {
                    // Run unit tests with Maven
                    sh 'mvn test'
                }
            }
        }

        stage('Docker Build') {
            steps {
                script {
                    // Build Docker image
                    sh 'docker build -t $DOCKER_IMAGE .'
                }
            }
        }

        stage('Docker Push') {
            steps {
                script {
                    // Push Docker image to the registry
                    sh 'docker push $DOCKER_IMAGE'
                }
            }
        }
    }

    post {
        always {
            // Perform any post actions if needed
            echo 'Pipeline execution finished.'
        }
    }
}
