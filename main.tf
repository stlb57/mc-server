provider "aws" {
  region = "us-east-1"
}

# 1. Create a Virtual Private Cloud (VPC)
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags       = { Name = "main-vpc" }
}

# 2. Create an Internet Gateway
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id
  tags   = { Name = "main-igw" }
}

# 3. Create a Route Table
resource "aws_route_table" "rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = { Name = "main-rt" }
}

# 4. Create a Subnet
resource "aws_subnet" "main" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  tags                    = { Name = "main-subnet" }
}

# 5. Associate the Route Table with our Subnet
resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.main.id
  route_table_id = aws_route_table.rt.id
}

# 6. Create a Security Group (Firewall)
resource "aws_security_group" "autominer_sg" {
  name        = "autominer-sg"
  description = "Allow traffic for Jenkins and Minecraft"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 25565
    to_port     = 25565
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# 7. Manage our SSH Key Pair
resource "aws_key_pair" "jenkins_key" {
  key_name   = "jenkins-key"
  public_key = file("jenkins-key.pub")
}

# 8. Create the EC2 Instance (The Server)
resource "aws_instance" "autominer_server" {
  ami                    = "ami-0360c520857e3138f" # Ubuntu 24.04 LTS in us-east-1
  instance_type          = "t2.small"
  key_name               = aws_key_pair.jenkins_key.key_name
  subnet_id              = aws_subnet.main.id
  vpc_security_group_ids = [aws_security_group.autominer_sg.id]

  user_data = <<-EOF
              #!/bin/bash
              sudo apt-get update -y
              sudo apt-get install -y openjdk-11-jre git docker.io
              sudo systemctl start docker
              sudo systemctl enable docker
              sudo usermod -aG docker ubuntu
              curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | sudo tee \
                /usr/share/keyrings/jenkins-keyring.asc > /dev/null
              echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
                https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
                /etc/apt/sources.list.d/jenkins.list > /dev/null
              sudo apt-get update -y
              sudo apt-get install -y jenkins
              sudo systemctl start jenkins
              sudo usermod -aG docker jenkins
              sudo systemctl restart jenkins
              EOF

  tags = {
    Name = "Jenkins-Autominer-Server"
  }
}

# Output the server's public IP
output "public_ip" {
  value = aws_instance.autominer_server.public_ip

}
