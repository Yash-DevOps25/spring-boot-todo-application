pipeline {
    agent any

    tools {
        // Ensure Maven and JDK are installed and configured in Jenkins
        maven 'Maven-3.8.7'
        jdk 'JDK-17'
    }

    environment {
        // Define the Docker image name for your app
        DOCKER_IMAGE = 'yourdockerhubusername/spring-boot-todo-app'
    }

    stages {
        stage('Checkout') {
            steps {
                // Checkout the latest code from the Git repository
               git branch: 'main', url: 'https://github.com/Yash-DevOps25/spring-boot-todo-application.git'

            }
        }

        stage('Build') {
            steps {
                // Build the project using Maven, skipping tests for speed
                sh 'mvn clean install -DskipTests'
            }
        }

        stage('Test') {
            steps {
                // Run the tests
                sh 'mvn test'
            }
        }

        stage('Docker Build') {
            steps {
                script {
                    // Build the Docker image
                    sh "docker build -t ${DOCKER_IMAGE}:${env.BUILD_NUMBER} ."
                }
            }
        }

        stage('Docker Push') {
            steps {
                script {
                    // Login to Docker Hub and push the image
                    withCredentials([usernamePassword(credentialsId: 'docker-hub-credentials', usernameVariable: 'DOCKERHUB_USERNAME', passwordVariable: 'DOCKERHUB_PASSWORD')]) {
                        sh "echo $DOCKERHUB_PASSWORD | docker login -u $DOCKERHUB_USERNAME --password-stdin"
                        sh "docker push ${DOCKER_IMAGE}:${env.BUILD_NUMBER}"
                    }
                }
            }
        }

        stage('Clean Up') {
            steps {
                // Clean up unused Docker images to free up space
                sh 'docker system prune -f'
            }
        }
    }

  //  post {
   //     always {
            // Archive the build artifacts (logs, etc.)
       //     archiveArtifacts artifacts: 'target/*.jar', allowEmptyArchive: true

            // Notify on build status
      //      mail to: 'you@example.com',
       //          subject: "Jenkins Build ${currentBuild.fullDisplayName} - ${currentBuild.result}",
        //        body: "Build result: ${currentBuild.result}\nCheck console output at ${env.BUILD_URL}"
        //}

        success {
            // Send success notification or perform post-build actions
            echo 'Build succeeded!'
        }

        failure {
            // Send failure notification or perform cleanup actions
            echo 'Build failed!'
        }
    }
}
