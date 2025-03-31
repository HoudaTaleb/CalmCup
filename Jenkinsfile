pipeline {
    agent any

    environment {
        FLUTTER_IMAGE = 'cirrusci/flutter:stable'
    }

    stages {
        stage('Checkout Code') {
            steps {
                git branch: 'main', url: 'https://github.com/HoudaTaleb/CalmCup'
            }
        }

        stage('Install Flutter Dependencies') {
            steps {
                sh "docker run --rm -v \$(pwd):/app -w /app ${FLUTTER_IMAGE} flutter pub get"
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
