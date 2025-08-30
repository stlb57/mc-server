pipeline {
    agent any
    parameters {
        choice(name: 'SERVER_TYPE', choices: ['vanilla', 'paper'], description: 'The server software to use.')
        choice(name: 'GAMEMODE', choices: ['survival', 'creative', 'spectator', 'adventure'], description: 'The game mode for players.')
        choice(name: 'LEVEL_TYPE', choices: ['default', 'flat', 'largeBiomes', 'amplified'], description: 'The type of world to generate.')
        string(name: 'LEVEL_SEED', defaultValue: '', description: '(Optional) Enter a world seed.')
    }

    stages {
        stage('Generate Config') {
            steps {
                script {
                    echo "Generating config: Gamemode=${params.GAMEMODE}, Level-Type=${params.LEVEL_TYPE}"
                    sh '''
                        echo "motd=Autominer Server | ${params.GAMEMODE}" > ./minecraft-server-config/server.properties
                        echo "gamemode=${params.GAMEMODE}" >> ./minecraft-server-config/server.properties
                        echo "level-type=${params.LEVEL_TYPE}" >> ./minecraft-server-config/server.properties
                        echo "level-seed=${params.LEVEL_SEED}" >> ./minecraft-server-config/server.properties
                    '''
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
