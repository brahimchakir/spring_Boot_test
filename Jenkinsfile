pipeline {
    agent any

    environment {
        JD_IMAGE = "my-springboot-app:${env.BUILD_ID}"
    }
    stages {
        stage('Clone Repo') {
            steps {
                git branch: 'main', url: 'https://github.com/brahimchakir/spring_Boot_test.git'
            }
        }
        stage('Build') {
            steps {
                sh './mvnw clean package -DskipTests'
            }
        }
        stage('Test') {
            steps {
                sh './mvnw test'
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    sh '''
                        echo "Docker environment:"
                        whoami
                        groups
                        ls -l /var/run/docker.sock
                        # Set permissions explicitly (no sudo needed)
                        chmod 666 /var/run/docker.sock
                        docker build -t my-springboot-app:1 .
                    '''
                    docker.build("${JD_IMAGE}", ".")
                }
            }
        }
        stage('Run Docker Container') {
            steps {
                sh "docker run -d -p 9090:8080 ${JD_IMAGE}"
            }
        }
    }
    post {
        always {
            cleanWs()
        }
        failure {
            echo 'Pipeline failed! Check logs for details.'
        }
    }
}
