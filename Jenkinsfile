pipeline {
    agent any

    environment {
        FLUTTER_IMAGE = 'cirrusci/flutter:stable'
        PROJECT_DIR = 'CalmCup' // <- adapte si nécessaire
    }

    stages {
        stage('Checkout Code') {
            steps {
                git url: 'https://github.com/HoudaTaleb/CalmCup', branch: 'main'
            }
        }

        stage('Install Flutter Dependencies') {
            steps {
                script {
                    docker.image(FLUTTER_IMAGE).inside {
                        sh 'flutter pub get'
                    }
                }
            }
        }

        stage('Analyze') {
            steps {
                script {
                    docker.image(FLUTTER_IMAGE).inside {
                        sh 'flutter analyze || true' // ne stoppe pas le pipeline en cas de warning
                    }
                }
            }
        }

        stage('Build APK') {
            steps {
                script {
                    docker.image(FLUTTER_IMAGE).inside {
                        sh 'flutter build apk --release'
                    }
                }
            }
        }

        stage('Archive APK') {
            steps {
                archiveArtifacts artifacts: '**/build/app/outputs/flutter-apk/app-release.apk', fingerprint: true
            }
        }
    }

    post {
        success {
            echo '✅ Build completed successfully!'
        }
        failure {
            echo '❌ Build failed.'
        }
    }
}
