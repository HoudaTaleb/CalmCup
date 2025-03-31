pipeline {
    agent any

    environment {
        FLUTTER_IMAGE = 'cirrusci/flutter:stable'
    }

    stages {
       

        stage('Install Flutter Dependencies') {
            steps {
                sh "flutter pub get"
            }
        }

        stage('Analyze') {
            steps {
                sh "docker run --rm -v \$(pwd):/app -w /app ${FLUTTER_IMAGE} flutter analyze || true"
            }
        }

        stage('Build APK') {
            steps {
                sh "docker run --rm -v \$(pwd):/app -w /app ${FLUTTER_IMAGE} flutter build apk --release"
            }
        }
    }

    post {
        failure {
            echo "❌ Build failed."
        }
        success {
            echo "✅ Build succeeded."
        }
    }
}
