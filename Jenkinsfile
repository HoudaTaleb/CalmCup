pipeline {
  agent any

  environment {
    PROJECT_NAME = "coffee-calm-jenkins"
    CONTAINER_NAME = "coffee-calm-container-jenkins"
    HOST_PORT = "5001"
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
        sh """
          docker run --rm \
            -v "\$PWD":/app \
            -w /app \
            cirrusci/flutter:stable \
            flutter build web
        """
      }
    }


    stage('Build Docker Image') {
      steps {
        sh "docker build -t $PROJECT_NAME ."
      }
    }

    stage('Run Docker Container') {
      steps {
        // Supprimer l’ancien conteneur s’il existe déjà
        sh """
          docker stop $CONTAINER_NAME || true
          docker rm $CONTAINER_NAME || true
        """

        // Lancer le nouveau container sur le port 5001
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
