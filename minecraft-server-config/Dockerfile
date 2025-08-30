FROM ubuntu:22.04
ENV DEBIAN_FRONTEND=noninteractive
WORKDIR /minecraft
RUN apt-get update && \
    apt-get install -y openjdk-17-jre-headless wget && \
    wget -O server.jar https://piston-data.mojang.com/v1/objects/f69c284232d7c7580bd89a5a4931c3581eae1378/server.jar && \
    echo "eula=true" > eula.txt && \
    apt-get clean
COPY server.properties .
EXPOSE 25565
CMD ["java", "-Xmx1024M", "-Xms1024M", "-jar", "server.jar", "nogui"]
