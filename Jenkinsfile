pipeline {
  agent any

  environment {
    PROJECT_NAME = "coffee-calm-web"
    CONTAINER_NAME = "coffee-calm-container"
    HOST_PORT = "3003"
  }

  stages {
    stage('Checkout') {
      steps {
        git branch: 'main', url: 'https://github.com/HoudaTaleb/CalmCup'
      }
    }
    stage('Test Docker Access') {
      steps {
        echo '🔍 Vérification de l\'accès à Docker...'
        sh 'docker --version'
      }
    }


    stage('Flutter Web Build') {
      steps {
        sh 'flutter build web'
      }
    }


    stage('Build Docker Image') {
      steps {
        sh "docker build -t $PROJECT_NAME ."
      }
    }


    stage('Run Docker Container') {
                steps {
                    sh "docker stop $CONTAINER_NAME || true"
                    sh "docker rm $CONTAINER_NAME || true"
                    sh "docker run -d --name $CONTAINER_NAME -p ${HOST_PORT}:80 $PROJECT_NAME"
                }
            }
  }

  post {
    success {
      echo "✅ Déploiement terminé ! Accède à http://localhost:${HOST_PORT}"
    }
    failure {
      echo "❌ Échec du pipeline"
    }
  }
}
