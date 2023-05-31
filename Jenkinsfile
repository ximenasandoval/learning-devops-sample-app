podTemplate(
    label: 'jenkins-pod-worker', 
    imagePullSecrets: ["regcred"], 
    containers: [
        containerTemplate(name: 'docker-custom', image: '377225462902.dkr.ecr.us-east-1.amazonaws.com/docker-aws-worker:latest', ttyEnabled: true),
        containerTemplate(name: 'python', image: 'python:3', ttyEnabled: true, command: 'bash')
    ],
    volumes: [
        hostPathVolume(mountPath: '/var/run/docker.sock', hostPath: '/var/run/docker.sock'),
    ]
) {
    node('jenkins-pod-worker') {
        git url: 'https://github.com/ximenasandoval/learning-devops-sample-app.git', branch: 'main'
        container('docker-custom') {
            stage('Push to ECR') {
                sh 'chmod +x deployment/deploy.sh'
                withAWS(credentials: 'aws-ecr-user', region: 'us-east-1') {
                    withCredentials([string(credentialsId: 'AWS_ACCOUNT_ID', variable: 'AWS_ACCOUNT_ID'), string(credentialsId: 'sample-app-ecr-repo-name', variable: 'ECR_REPO_NAME')]) {
                        sh 'sh deployment/deploy.sh'
                    }
                }
            }
        }
    }
}