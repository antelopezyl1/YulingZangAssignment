
/* Requires the Docker Pipeline plugin */
pipeline {
    agent { docker { 
            image 'python:3.13.7-alpine3.22'
            // 添加 customLauncher 明确指定 Docker 可执行文件的位置
            customLauncher '/opt/homebrew/bin/docker' 
            // 假设你的路径是 /opt/homebrew/bin/docker，请替换为你的实际路径！
        } 
        image 'python:3.13.7-alpine3.22' } 
    stages {
        stage('build') {
            steps {
                sh 'python --version'
            }
        }
    }
}
