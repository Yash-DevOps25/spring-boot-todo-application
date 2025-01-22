pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'your-dockerhub-username/spring-boot-todo-app'
        DOCKER_CREDENTIALS_ID = 'dockerhub-credentials' // Jenkins credentials ID for Docker Hub
    }

    stages {
        stage('Checkout Code') {
            steps {
                // Pull code from the Git repository
                git branch: 'main', url: 'https://github.com/wazooinc/spring-boot-todo-application.git'
            }
        }

        stage('Build Application') {
            steps {
                // Use Maven to build the application
                sh 'mvn clean package'
            }
        }

        stage('Build Docker Image') {
            steps {
                // Build Docker image
                sh """
                docker build -t ${DOCKER_IMAGE}:latest .
                """
            }
        }

        stage('Run Docker Container') {
            steps {
                // Run Docker container in the background
                sh """
                docker run -d -p 8080:8080 --name spring-boot-todo-app ${DOCKER_IMAGE}:latest
                """
            }
        }

        stage('Test Application') {
            steps {
                // Test if the application is accessible
                script {
                    def response = sh(script: 'curl -s -o /dev/null -w "%{http_code}" http://localhost:8080', returnStdout: true).trim()
                    if (response != '200') {
                        error "Application did not respond with HTTP 200, but with HTTP ${response}"
                    }
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                // Login to Docker Hub and push the image
                script {
                    docker.withRegistry('https://registry.hub.docker.com', DOCKER_CREDENTIALS_ID) {
                        sh "docker push ${DOCKER_IMAGE}:latest"
                    }
                }
            }
        }

        stage('Clean Up') {
            steps {
                // Clean up by stopping and removing the container
                sh """
                docker stop spring-boot-todo-app
                docker rm spring-boot-todo-app
                """
            }
        }
    }

    post {
        always {
            // Cleanup workspace
            cleanWs()
        }
        success {
            echo 'Pipeline executed successfully!'
        }
        failure {
            echo 'Pipeline execution failed!'
        }
    }
}
