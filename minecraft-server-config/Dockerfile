# Start with a base image that has Java 17 installed
FROM openjdk:17-jre-slim
WORKDIR /server

# Download the official Minecraft server file
# You can update this URL for newer versions of Minecraft
RUN apt-get update && apt-get install -y curl && \
    curl -o server.jar https://piston-data.mojang.com/v1/objects/84194a2f286ef7c14ed7ce0090dba59902951553/server.jar

# Automatically accept the Minecraft EULA
RUN echo "eula=true" > eula.txt

# Copy your server configuration file from the Git repo into the image
COPY server.properties .

# Expose the default Minecraft server port
EXPOSE 25565

# Command to run the server with 2GB of RAM
CMD ["java", "-Xmx2G", "-Xms1G", "-jar", "server.jar", "nogui"]