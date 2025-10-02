pipeline {
  agent any
  // 保险起见，把 docker 可能所在目录也并进 PATH
  environment {
    PATH = "/usr/local/bin:/opt/homebrew/bin:/Applications/Docker.app/Contents/Resources/bin:${env.PATH}"
  }
  tools {
    dockerTool 'Docker_local'   // 使用你在 UI 里命名的 Docker 安装
  }
  stages {
    stage('build') {
      steps {
        // 可选：自检，确认能找到 docker
        sh '''
          echo "PATH=$PATH"
          which docker
          docker --version
        '''
        script {
          docker.image('python:3.13.7-alpine3.22').inside {
            sh 'python --version'
          }
        }
      }
    }
  }
}
