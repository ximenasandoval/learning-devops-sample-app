podTemplate(label: 'jenkins-worker', containers: [
    containerTemplate(name: 'docker', image: 'docker', command: 'cat', ttyEnabled: true),
    containerTemplate(name: 'git', image: 'alpine/git', ttyEnabled: true, command: 'cat'),
    containerTemplate(name: 'python', image: 'python:3', ttyEnabled: true, command: 'bash')
  ],
  volumes: [
    hostPathVolume(mountPath: '/var/run/docker.sock', hostPath: '/var/run/docker.sock'),
  ]
  ) {
    node('jenkins-worker') {
        stage('Check running containers') {
            container('git') {
                sh 'git clone https://github.com/ximenasandoval/learning-devops-sample-app.git'
            }
            container('python') {
                dir('learning-devops-sample-app/') {
                    sh 'ls -a'
                    sh 'echo This is were a test would be run'
                }
            }
            container('docker') {
                dir('learning-devops-sample-app/') {
                    sh 'echo This is were the image will be built'
                    sh 'docker ps'
                    sh 'ls -a'
                }
            }
        }
    }
}