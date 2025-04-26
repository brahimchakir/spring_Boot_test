pipeline {
    agent any

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
                    docker.build("my-springboot-app:${env.BUILD_ID}", ".")
                }
            }
        }
        stage('Run Docker Container') {
            steps {
                docker.image("my-springboot-app:${env.BUILD_ID}").run("-p 8080:8080")
            }
        }
    }
}
