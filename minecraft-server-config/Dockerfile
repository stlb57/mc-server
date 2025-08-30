# Start with a standard Ubuntu base image, which we know works on your server
FROM ubuntu:22.04

# Set non-interactive mode for package installations to prevent it from getting stuck
ENV DEBIAN_FRONTEND=noninteractive

# Update the image and install Java 17, curl, and other needed tools
RUN apt-get update && apt-get install -y openjdk-17-jre-headless curl && apt-get clean

# Set the working directory
WORKDIR /server

# Download the official Minecraft server jar file
RUN curl -o server.jar https://piston-data.mojang.com/v1/objects/84194a2f286ef7c14ed7ce0090dba59902951553/server.jar

# Automatically accept the Minecraft EULA
RUN echo "eula=true" > eula.txt

# Copy your server configuration file
COPY server.properties .

# Expose the default Minecraft server port
EXPOSE 25565

# Command to run the server with 2GB of RAM
CMD ["java", "-Xmx2G", "-Xms1G", "-jar", "server.jar", "nogui"]
