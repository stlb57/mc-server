pipeline {
    agent any
    stages {
        stage('Build Minecraft Server Image') {
            steps {
                script {
                    echo 'BUILDING THE SERVER IMAGE'
                    sh 'docker build -t minecraft-server:latest ./minecraft-server-config'
                }
            }
        }

        stage('Launch Minecraft Server') {
            steps {
                script {
                    echo 'REMOVING ANY OLD SERVERS AND RUNNING ONE...'
                    sh 'docker rm -f mc-server || true'
                    sh 'docker run -d --name mc-server -p 25565:25565 minecraft-server:latest'
                }
            }
        }
    }
}
