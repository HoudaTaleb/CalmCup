pipeline {
    agent any  // Utilise n'importe quel agent disponible

    environment {
        FLUTTER_HOME = "/usr/local/flutter"
    }

    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/HoudaTaleb/CalmCup.git'
            }
        }

        stage('Install Flutter Dependencies') {
            steps {
                sh 'flutter pub get'
            }
        }

        stage('Run Tests') {
            steps {
                sh 'flutter test'
            }
        }

        stage('Build APK') {
            steps {
                sh 'flutter build apk'
            }
        }
    }
}
