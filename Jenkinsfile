pipeline {
    agent any

    environment {
        // Ensure the paths to JDK and Maven are correctly configured
        MAVEN_HOME = '/opt/apache-maven-3.8.7'
        JDK_HOME = '/usr/lib/jvm/java-17-openjdk'
    }

    tools {
        jdk 'JDK-17' // Ensure this matches the JDK name in your Jenkins tool configuration
        maven 'Maven 3.8.7' // Ensure this matches the Maven tool name in Jenkins
    }

    stages {
        stage('Checkout SCM') {
            steps {
                checkout scm
            }
        }

        stage('Build') {
            steps {
                script {
                    // Increase the build timeout to avoid early timeouts
                    timeout(time: 1, unit: 'HOURS') {
                        sh '''
                            echo "Building the application"
                            mvn clean package
                        '''
                    }
                }
            }
        }

        stage('Docker Build') {
            when {
                expression {
                    return currentBuild.result == 'SUCCESS'
                }
            }
            steps {
                script {
                    // Docker build commands here
                    echo 'Building Docker image...'
                    sh '''
                        docker build -t spring-boot-todo-app .
                    '''
                }
            }
        }

        stage('Docker Run') {
            when {
                expression {
                    return currentBuild.result == 'SUCCESS'
                }
            }
            steps {
                script {
                    // Docker run commands here
                    echo 'Running Docker container...'
                    sh '''
                        docker run -d -p 8080:8080 spring-boot-todo-app
                    '''
                }
            }
        }

        stage('Test') {
            when {
                expression {
                    return currentBuild.result == 'SUCCESS'
                }
            }
            steps {
                script {
                    // Example test command
                    echo 'Running tests...'
                    sh '''
                        mvn test
                    '''
                }
            }
        }
    }

    post {
        success {
            echo 'Build and Docker stages completed successfully!'
        }
        failure {
            echo 'Build failed!'
        }
    }
}

