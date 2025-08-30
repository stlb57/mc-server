pipeline {
    agent any

    stages {
        stage('Build Minecraft Server Image') {
            steps {
                script {
                    echo 'Building the Minecraft server Docker image...'
                    // --- THIS IS THE CORRECTED LINE ---
                    // We tell Docker to use the 'minecraft-server-config' folder as the build context.
                    sh 'docker build -t minecraft-server:latest ./minecraft-server-config'
                }
            }
        }
        stage('Launch Minecraft Server') {
            steps {
                script {
                    echo 'Stopping any old server and launching the new one...'
                    sh 'docker rm -f mc-server || true'
                    sh 'docker run -d --name mc-server -p 25565:25565 minecraft-server:latest'
                }
            }
        }
    }
}
