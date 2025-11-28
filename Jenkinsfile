pipeline {
    agent any

    environment {
        IMAGE_NAME = "angularapp"
        GIT_REPO = "https://github.com/juandedioslozanomtz-boop/TestAngular.git" // Cambia por tu repo
        GIT_BRANCH = "main"                                       // Cambia por tu rama
    }

    stages {
    stage('Prepare Node') {
            steps {
                sh """
                # Install Node 24 if not exists
                if ! command -v node >/dev/null; then
                    curl -fsSL https://deb.nodesource.com/setup_24.x | bash -
                    apt-get install -y nodejs
                fi
                node -v
                npm -v
                """
            }
        }
        stage('Checkout') {
            steps {
                echo "Cloning repository ${GIT_REPO} branch ${GIT_BRANCH}"
                git branch: "${GIT_BRANCH}", url: "${GIT_REPO}"
            }
        }

        stage('Install & Build Angular 21') {
            steps {
                echo "Installing dependencies and building Angular 21 app"
                sh """
                npm ci
                npm run build -- --configuration production
                """
            }
        }

        stage('Build Docker Image') {
            steps {
                echo "Building Docker image: ${IMAGE_NAME}:latest"
                sh "docker build -t ${IMAGE_NAME}:latest ."
            }
        }

        stage('Deploy via Docker Compose') {
            steps {
                echo "Deploying Angular app via Docker Compose"
                sh """
                docker compose down angular-app || true
                docker compose up -d angular-app
                """
            }
        }
    }

    post {
        success {
            echo "Pipeline completed successfully!"
        }
        failure {
            echo "Pipeline failed! Check logs for details."
        }
    }
}
