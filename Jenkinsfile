pipeline {
    agent any

    stages {
        stage('Build Minecraft Server Image') {
            steps {
                script {
                    echo 'Building the Minecraft server Docker image...'
                    // Build the image using the Dockerfile in our Git repo
                    sh 'docker build -t minecraft-server:latest .'
                }
            }
        }
        stage('Launch Minecraft Server') {
            steps {
                script {
                    echo 'Stopping any old server and launching the new one...'
                    // Stop and remove any container named "mc-server" if it exists, then launch the new one
                    sh 'docker rm -f mc-server || true'
                    sh 'docker run -d --name mc-server -p 25565:25565 minecraft-server:latest'
                }
            }
        }
    }
}