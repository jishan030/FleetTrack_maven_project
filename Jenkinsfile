```groovy
pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main',
                    url: 'https://github.com/jishan030/FleetTrack_maven_project.git'
            }
        }

        stage('Backend Build') {
            steps {
                dir('backend') {
                    sh 'mvn clean package -DskipTests'
                }
            }
        }

        stage('SonarQube Analysis') {
            steps {
                dir('backend') {
                    withCredentials([
                        string(credentialsId: 'sonarqube-token',
                               variable: 'SONAR_TOKEN')
                    ]) {
                        sh '''
                            mvn org.sonarsource.scanner.maven:sonar-maven-plugin:sonar \
                            -Dsonar.projectKey=jishan030_FleetTrack_maven_project \
                            -Dsonar.organization=jishan030 \
                            -Dsonar.host.url=https://sonarcloud.io \
                            -Dsonar.token="$SONAR_TOKEN"
                        '''
                    }
                }
            }
        }

        stage('Frontend Build') {
            steps {
                dir('frontend') {
                    sh 'npm ci'
                    sh 'npm run build'
                }
            }
        }

        stage('Build Completed') {
            steps {
                echo 'FleetTrack CI + SonarQube Analysis Completed!'
            }
        }
    }
}
```