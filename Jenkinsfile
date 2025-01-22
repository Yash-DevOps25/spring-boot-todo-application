pipeline {
    agent any

    tools {
        jdk 'JDK-17'  // Ensure JDK 17 is configured in Jenkins Global Tool Configuration
        maven 'Maven 3.8.7' // Ensure Maven 3.8.7 is available in Jenkins
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build Application') {
            steps {
                sh 'mvn clean package'
            }
        }

        stage('Build Docker Image') {
            when {
                not {
                    failed()
                }
            }
            steps {
                sh 'docker build -t my-todo-app .'
            }
        }

        stage('Run Docker Container') {
            when {
                not {
                    failed()
                }
            }
            steps {
                sh 'docker run -d -p 8080:8080 --name todo-app-container my-todo-app'
            }
        }

        stage('Test Application') {
            when {
                not {
                    failed()
                }
            }
            steps {
                sh 'curl http://localhost:8080'
            }
        }

        stage('Push Docker Image') {
            when {
                not {
                    failed()
                }
            }
            steps {
                sh 'docker tag my-todo-app my-docker-repo/todo-app:latest'
                sh 'docker push my-docker-repo/todo-app:latest'
            }
        }
    }

    post {
        always {
            script {
                if (currentBuild.result != 'FAILURE') {
                    echo "Skipping Clean Up stage since the build was successful."
                } else {
                    echo "Skipping Clean Up as it failed earlier."
                }
            }
        }

        failure {
            echo 'Build failed!'
        }
    }
}
