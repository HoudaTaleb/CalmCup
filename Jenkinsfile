pipeline {
    agent any

    environment {
        PATH = "/opt/flutter/bin:${env.PATH}"
    }

    stages {
        stage('Cloner le projet') {
            steps {
                git 'https://github.com/HoudaTaleb/CalmCup.git'
            }
        }
        stage('Installer les dépendances') {
            steps {
                sh 'flutter pub get'
            }
        }
        stage('Analyse statique') {
            steps {
                sh 'flutter analyze'
            }
        }
        stage('Tests unitaires') {
            steps {
                sh 'flutter test'
            }
        }
        stage('Build APK') {
            steps {
                sh 'flutter build apk'
            }
        }
        stage('Archiver APK') {
            steps {
                archiveArtifacts artifacts: '**/app/build/**/*.apk', fingerprint: true
            }
        }
    }
}
