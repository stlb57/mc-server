FROM amazoncorretto:17-al2-jdk
WORKDIR /server
ARG SERVER_TYPE=vanilla
RUN yum install -y curl && \
    if [ "$SERVER_TYPE" = "paper" ]; then \
        echo "Downloading PaperMC server..."; \
        curl -o server.jar https://api.papermc.io/v2/projects/paper/versions/1.20.1/builds/112/downloads/paper-1.20.1-112.jar; \
    else \
        echo "Downloading Vanilla server..."; \
        curl -o server.jar https://piston-data.mojang.com/v1/objects/84194a2f286ef7c14ed7ce0090dba59902951553/server.jar; \
    fi
RUN echo "eula=true" > eula.txt
COPY server.properties .
EXPOSE 25565
CMD ["java", "-Xmx2G", "-Xms1G", "-jar", "server.jar", "nogui"]
