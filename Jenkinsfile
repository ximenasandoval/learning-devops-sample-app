pipeline {
    agent {
        kubernetes {
            defaultContainer 'jnlp'
            idleMinutes 1
        }
    }
    stages {
        stage('Sample Stage') {
            parallel {
            stage('this runs in a pod') {
                steps {
                    container('jnlp') {
                        sh 'uptime'
                        }
                    }
                }
            }
        }
    }
}