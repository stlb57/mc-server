pipeline {
    agent any

    parameters {
        choice(name: 'SERVER_TYPE', choices: ['vanilla', 'paper'], description: 'The server software to use.')
        choice(name: 'RAM_ALLOCATION', choices: ['1G', '1.5G'], description: 'RAM to allocate to the Minecraft server (max for t2.small is ~1.7G).')
        choice(name: 'GAMEMODE', choices: ['survival', 'creative', 'spectator', 'adventure'], description: 'The game mode for players.')
        choice(name: 'DIFFICULTY', choices: ['peaceful', 'easy', 'normal', 'hard'], description: 'The server difficulty.')
        choice(name: 'PVP', choices: ['true', 'false'], description: 'Enable or disable Player vs. Player.')
        choice(name: 'LEVEL_TYPE', choices: ['default', 'flat', 'largeBiomes', 'amplified'], description: 'The type of world to generate.')
        string(name: 'LEVEL_SEED', defaultValue: '', description: '(Optional) Enter a world seed.')
    }

    stages {
        stage('Generate Config') {
            steps {
                script {
                    echo "Generating config file..."
                    def serverConfig = """
                        motd=Autominer Server | ${params.GAMEMODE}
                        gamemode=${params.GAMEMODE}
                        difficulty=${params.DIFFICULTY}
                        pvp=${params.PVP}
                        level-type=${params.LEVEL_TYPE}
                        level-seed=${params.LEVEL_SEED}
                    """
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

