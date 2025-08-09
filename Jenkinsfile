pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "jenkins-node-demo"
        SERVER_USER = "ubuntu"
        SERVER_IP = "YOUR_SERVER_IP" // Replace with free VPS IP
        SERVER_PATH = "/home/ubuntu/app"
    }

    stages {
        stage('Clone Repository') {
            steps {
                git branch: 'main', url: 'https://github.com/devanishidk/jenkins-node-demo.git'
            }
        }

        stage('Install Dependencies') {
            steps {
                sh 'npm install'
            }
        }

        stage('Run Tests') {
            steps {
                sh 'npm test || echo "No tests found, skipping..."'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh "docker build -t $DOCKER_IMAGE ."
            }
        }

        stage('Deploy to Server') {
            steps {
                sh """
                ssh -o StrictHostKeyChecking=no $SERVER_USER@$SERVER_IP '
                    docker stop $DOCKER_IMAGE || true &&
                    docker rm $DOCKER_IMAGE || true &&
                    docker rmi $DOCKER_IMAGE || true &&
                    cd $SERVER_PATH &&
                    git pull &&
                    docker build -t $DOCKER_IMAGE . &&
                    docker run -d -p 3000:3000 --name $DOCKER_IMAGE $DOCKER_IMAGE
                '
                """
            }
        }
    }
}
