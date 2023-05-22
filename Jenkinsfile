pipeline {
    agent {
        docker {
            image 'python:3'
            args '-p 5000:5000'
        }
    }
    stages {
        stage('Build') {
            steps {
                sh 'echo Building!'
            }
        }
    }
}