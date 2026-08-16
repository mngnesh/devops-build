pipeline {
    agent any

    environment {
        DOCKERHUB_REPO = "mngnesh"
        IMAGE_NAME = "devops-build-app"
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Determine Docker Repository') {
            steps {
                script {
                    if (env.BRANCH_NAME == 'dev') {
                        env.DOCKER_REPOSITORY = 'dev'
                    } else if (env.BRANCH_NAME == 'master') {
                        env.DOCKER_REPOSITORY = 'prod'
                    } else {
                        error("Unsupported branch: ${env.BRANCH_NAME}")
                    }

                    echo "Branch: ${env.BRANCH_NAME}"
                    echo "Docker repository: ${env.DOCKERHUB_REPO}/${env.DOCKER_REPOSITORY}"
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t $IMAGE_NAME:latest .'
                sh 'docker tag $IMAGE_NAME:latest $DOCKERHUB_REPO/$DOCKER_REPOSITORY:latest'
            }
        }

        stage('Push to Docker Hub') {
            steps {
                withCredentials([
                    usernamePassword(
                        credentialsId: 'dockerhub-credentials',
                        usernameVariable: 'DOCKER_USERNAME',
                        passwordVariable: 'DOCKER_PASSWORD'
                    )
                ]) {
                    sh '''
                        echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin
                        docker push "$DOCKERHUB_REPO/$DOCKER_REPOSITORY:latest"
                        docker logout
                    '''
                }
            }
        }
    }

    post {
        always {
            sh 'docker image prune -f || true'
        }
    }
}
