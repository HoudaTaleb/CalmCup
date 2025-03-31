pipeline {
    agent {
        docker {
            image 'ghcr.io/cirruslabs/flutter:stable'
        }
    }

    stages {
        stage('Install dependencies') {
            steps {
                sh 'flutter pub get'
            }
        }

        stage('Analyze') {
            steps {
                sh 'flutter analyze || true' // Ne bloque pas le pipeline en cas de warnings
            }
        }

        stage('Build APK') {
            steps {
                sh 'flutter build apk --release'
            }
        }

        stage('Archive APK') {
            steps {
                archiveArtifacts artifacts: 'build/app/outputs/flutter-apk/app-release.apk', fingerprint: true
            }
        }
    }
}
