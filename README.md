# The Genesis Pipeline 🚀  
_On-Demand Minecraft Server Platform_

A dynamic, on-demand Minecraft server deployment platform. This project uses a professional **DevOps toolchain** to create a user-driven system where custom game servers can be configured and launched in minutes—all through a simple web interface.  

This is more than a simple script; it's a small-scale **"Server as a Service"** platform built on the principles of **Infrastructure as Code (IaC)** and **CI/CD**.  

---

## ⭐ Key Features
- **On-Demand Server Creation**: Configure server settings like gamemode, world type, and server software directly in the Jenkins UI.  
- **Dynamic Configuration**: The `server.properties` file is generated dynamically for each build.  
- **Infrastructure as Code**: Entire cloud environment (server, networking, firewall) is defined and managed with Terraform.  
- **Fully Automated CI/CD**: Parameterized Jenkins pipeline automates config generation, build, and deployment.  
- **Containerized Environment**: Minecraft servers run inside clean, isolated, portable Docker containers.  

---

## 🛠️ Tech Stack
- **Automation**: Jenkins  
- **Infrastructure**: Terraform  
- **Cloud Provider**: AWS (EC2)  
- **Containerization**: Docker  
- **Version Control**: Git & GitHub  

---

## ⚙️ How It Works
1. **Provision**  
   - Run `terraform apply` to build the host server on AWS.  
   - Terraform installs and configures **Jenkins** and **Docker** automatically.  

2. **Configure**  
   - Access the Jenkins dashboard in your browser.  
   - Click **Build with Parameters**.  

3. **Select Options**  
   - Choose server type, gamemode, level type, and optional world seed.  

4. **Generate**  
   - Jenkins generates a **custom `server.properties` file**.  

5. **Build**  
   - Jenkins builds a new Docker image using a multi-stage Dockerfile.  
   - Correct server software is downloaded and configuration is applied.  

6. **Deploy**  
   - Old containers are stopped.  
   - A new, customized server container is launched.  

7. **Play**  
   - The server goes live.  
   - Connect directly from your Minecraft client.  

---

## 🚀 Setup & Usage

### 1. Clone the Repository
```bash
git clone <your-repo-url>
cd <project-directory>
