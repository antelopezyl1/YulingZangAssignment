pipeline {
  agent any
  environment {
    // 把 docker 可能所在的目录并入 PATH（mac 常见三处）
    PATH = "/usr/local/bin:/opt/homebrew/bin:/Applications/Docker.app/Contents/Resources/bin:${env.PATH}"
  }
  stages {
    stage('build') {
      steps {
        sh '''
          echo "PATH=$PATH"
          which docker
          docker --version
          docker run --rm python:3.13.7-alpine3.22 python --version
        '''
      }
    }
  }
}

