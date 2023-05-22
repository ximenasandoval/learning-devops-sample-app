podTemplate(label: 'mypod', containers: [
    containerTemplate(name: 'docker', image: 'docker', command: 'cat', ttyEnabled: true),
    containerTemplate(name: 'git', image: 'alpine/git', ttyEnabled: true, command: 'cat'),
    containerTemplate(name: 'python', image: 'python:3', ttyEnabled: true, command: 'bash')
  ],
  volumes: [
    hostPathVolume(mountPath: '/var/run/docker.sock', hostPath: '/var/run/docker.sock'),
  ]
  ) {
    node('mypod') {
        stage('Check running containers') {
            container('docker') {
                // example to show you can run docker commands when you mount the socket
                sh 'hostname'
                sh 'hostname -i'
                sh 'docker ps'
                sh 'pwd'
            }
            container('git') {
                sh 'git clone https://github.com/ximenasandoval/learning-devops-sample-app.git'
            }
            container('python') {
                dir('learning-devops-sample-app/') {
                    sh 'ls -a'
                }
            }
        }
    }
}