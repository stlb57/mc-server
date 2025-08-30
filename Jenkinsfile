pipeline {
    agent any

    parameters {
        choice(name: 'SERVER_TYPE', choices: ['vanilla', 'paper'], description: 'The server software to use.')
        choice(name: 'GAMEMODE', choices: ['survival', 'creative', 'spectator', 'adventure'], description: 'The game mode for players.')
        choice(name: 'LEVEL_TYPE', choices: ['default', 'flat', 'largeBiomes', 'amplified'], description: 'The type of world to generate.')
        string(name: 'LEVEL_SEED', defaultValue: '', description: '(Optional) Enter a world seed.')
    }

    stages {
        // This stage now uses the robust 'writeFile' command
        stage('Generate Config') {
            steps {
                script {
                    echo "Generating config file..."
                    // Define the content of our server.properties file
                    def serverConfig = """
                        motd=Autominer Server | ${params.GAMEMODE}
                        gamemode=${params.GAMEMODE}
                        level-type=${params.LEVEL_TYPE}
                        level-seed=${params.LEVEL_SEED}
                    """
                    // Use the native Jenkins step to safely write the file
                    writeFile file: './minecraft-server-config/server.properties', text: serverConfig
                }
            }
        }

        stage('Build Minecraft Server Image') {
            steps {
                script {
                    echo "Building a '${params.SERVER_TYPE}' server image..."
                    sh "docker build --build-arg SERVER_TYPE=${params.SERVER_TYPE} -t minecraft-server:latest ./minecraft-server-config"
                }
            }
        }
        
        stage('Launch Minecraft Server') {
            steps {
                script {
                    echo 'Launching the new server...'
                    sh 'docker rm -f mc-server || true'
                    sh 'docker run -d --name mc-server -p 25565:25565 minecraft-server:latest'
                }
            }
        }
    }
}
