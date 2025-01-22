pipeline {
    agent any

    tools {
        jdk 'JDK-17' // Ensure this matches the JDK name in your Jenkins tool configuration
        maven 'Maven 3.8.7' // Ensure this matches the Maven name in your Jenkins tool configuration
    }

    environment {
        DOCKER_IMAGE = 'my-app-image' // Define your Docker image name here
    }

    stages {
        stage('Build') {
            steps {
                script {
                    try {
                        // Build the application using Maven
                        sh 'mvn package'
                    } catch (Exception e) {
                        currentBuild.result = 'FAILURE' // Mark the build as failed
                        throw e // Re-throw to fail the build
                    }
                }
            }
        }
        
        stage('Docker Build') {
            steps {
                script {
                    try {
                        // Build Docker image
                        sh 'docker build -t ${DOCKER_IMAGE} .'
                    } catch (Exception e) {
                        currentBuild.result = 'FAILURE' // Mark the build as failed if Docker fails
                        throw e // Re-throw to fail the build
                    }
                }
            }
        }
        
        stage('Docker Run') {
            steps {
                script {
                    try {
                        // Run Docker container (adjust command as necessary)
                        sh 'docker run -d -p 8080:8080 ${DOCKER_IMAGE}'
                    } catch (Exception e) {
                        currentBuild.result = 'FAILURE' // Mark the build as failed if Docker run fails
                        throw e // Re-throw to fail the build
                    }
                }
            }
        }
        
        stage('Test') {
            steps {
                script {
                    if (currentBuild.result == 'FAILURE') {
                        error 'Build failed, skipping tests.'
                    }
                    // Add your testing steps here
                }
            }
        }
    }

    post {
        failure {
            echo 'Build failed!'
            // Additional actions for failure (e.g., notifications)
        }
    }
}
