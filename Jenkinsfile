pipeline {
    agent any

    environment {
        IMAGE_NAME = "yashguj20/spring-boot-todo-app"   // Replace with your actual image name
        CONTAINER_NAME = "springboot-todo-app"
        COMPOSE_FILE = "docker-compose.yml"
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/Yash-DevOps25/spring-boot-todo-application.git'
// Your repo
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    sh '''
                        docker build -t $IMAGE_NAME .
                    '''
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    sh '''
                        docker tag $IMAGE_NAME your-dockerhub-user/$IMAGE_NAME:latest
                        docker push your-dockerhub-user/$IMAGE_NAME:latest
                    '''
                }
            }
        }

        stage('Deploy with Docker Compose') {
            steps {
                script {
                    sh '''
                        docker stop $CONTAINER_NAME || true
                        docker rm $CONTAINER_NAME || true
                        docker-compose -f $COMPOSE_FILE up -d
                    '''
                }
            }
        }
    }

    post {
        success {
            echo "Deployment Successful!"
        }
        failure {
            echo "Pipeline failed. Check the logs for errors."
        }
    }
}
