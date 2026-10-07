pipeline {

    agent any

    tools {
        jdk 'JDK17'
        maven 'Maven3'
    }

    stages {

        stage('Checkout') {
            steps {
                git branch: 'main', url:'https://github.com/sreenivas-shamala/flask-app.git'
                
            }
        }

        stage('Clean') {
            steps {
                sh 'mvn clean'
            }
        }

        stage('Run Selenium Tests') {
            steps {
                sh 'mvn test'
            }
        }
    }

    post {

        always {

            junit(
                testResults: 'target/surefire-reports/*.xml',
                allowEmptyResults: true
            )

            archiveArtifacts(
                artifacts: 'screenshots/**/*.png',
                allowEmptyArchive: true
            )
        }

        success {
            echo 'Selenium test execution completed successfully.'
        }

        failure {
            echo 'Selenium test execution failed.'
        }
    }
}
