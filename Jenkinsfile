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
        container('docker-custom') {
            stage('Get app repository') {
                sh 'git clone https://github.com/ximenasandoval/learning-devops-sample-app.git'
                sh 'ls'
                sh 'pwd'
            }
            stage('Push to ECR') {
                dir('learning-devops-sample-app') {
                    sh 'chmod +x deployment/deploy.sh'
                    withAWS(credentials: 'aws-ecr-user', region: 'us-east-1') {
                        withCredentials([string(credentialsId: 'AWS_ACCOUNT_ID', variable: 'AWS_ACCOUNT_ID'), string(credentialsId: 'sample-app-ecr-repo-name', variable: 'ECR_REPO_NAME')]) {
                            sh 'sh deployment/deploy.sh'
                        }
                    }
                }
            }
            stage('Get ArgoCD configuration repository') {
                sh 'git clone https://github.com/ximenasandoval/learning-devops-argocd-configs'
            }
            stage('Update ArgoCD configuration') {
                dir('learning-devops-argocd-configs') {
                    withCredentials([gitUsernamePassword(credentialsId: 'XSDH-deployer-credentials', gitToolName: 'Default')]) {
                        sh '''
                        export ENVIRONMENT=development
                        export APP_PATH=sample-app/radio.yml
                        cat ${ENVIRONMENT}/${APP_PATH}
                        export CURRENT_VERSION=$(cat ${ENVIRONMENT}/${APP_PATH} | yq ".spec.template.spec.containers[0].image" | sed 's/.*://')
                        export TARGET_VERSION=$(cat ../learning-devops-sample-app/.version | sed 's/.*://')
    
                        sed -i -e "s|$CURRENT_VERSION|$TARGET_VERSION|" ${ENVIRONMENT}/${APP_PATH}
                        cat ${ENVIRONMENT}/${APP_PATH}
                        
                        git config --global user.email "xdh.deployer@gmail.com"
                        git config --global user.name "xsdh-deployer"

                        git add ${ENVIRONMENT}/${APP_PATH}
                        git commit -m "Deploy version"
                        git push
                        '''
                    }
                }
            }
        }
    }
}