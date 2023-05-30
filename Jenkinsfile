podTemplate(
    label: 'jenkins-worker', 
    imagePullSecrets: ["regcred"], 
    containers: [
        containerTemplate(name: 'docker-custom', image: '377225462902.dkr.ecr.us-east-1.amazonaws.com/docker-aws-worker:latest', ttyEnabled: true, command: 'cat'),
    ],
    volumes: [
        hostPathVolume(mountPath: '/var/run/docker.sock', hostPath: '/var/run/docker.sock'),
    ]
) {
    node('jenkins-worker') {
        stage('Get a project') {
            git url: 'https://github.com/ximenasandoval/learning-devops-sample-app.git', branch: 'main'
            container('docker-custom') {
                stage('Build image') {
                    sh 'chmod +x deployment/deploy.sh'
                    sh 'sh deployment/deploy.sh'
                }
            }
        }
    }
}