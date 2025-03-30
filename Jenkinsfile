pipeline {
    agent {
        docker {
            image 'cirrusci/flutter:stable'
            args '-u root:root'  // important pour avoir les permissions
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
                sh 'flutter analyze'
            }
        }
        stage('Test') {
            steps {
                sh 'flutter test'
            }
        }
        stage('Build APK') {
            steps {
                sh 'flutter build apk'
            }
        }
        stage('Archive APK') {
            steps {
                archiveArtifacts artifacts: '**/build/app/outputs/**/*.apk', fingerprint: true
            }
        }
    }
}
