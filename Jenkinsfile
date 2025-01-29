pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'yashguj20/spring-boot-todo-app' // Docker Hub username and repository name
        REGISTRY = 'docker.io'
        GIT_URL = 'https://github.com/Yash-DevOps25/spring-boot-todo-application.git'
        JAVA_HOME = '/usr/lib/jvm/java-17-openjdk-amd64' // Set JAVA_HOME to Java 17 path
    }

    tools {
        maven 'Apache Maven 3.8.7' // Maven version specified in Jenkins
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
                    sh "docker build -t ${DOCKER_IMAGE} ."
                }
            }
        }

        stage('Docker Login') {
            steps {
                script {
                    // Log in to Docker Hub
                    withCredentials([usernamePassword(credentialsId: 'docker-hub-credential', usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
                        sh "echo $DOCKER_PASSWORD | docker login -u $DOCKER_USERNAME --password-stdin"
                    }
                }
            }
        }

        stage('Docker Push') {
            steps {
                script {
                    // Push Docker image to the registry
                    sh "docker push ${DOCKER_IMAGE}"
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
