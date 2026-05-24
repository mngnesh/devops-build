DevOps Build & Deployment Project 🚀

This project demonstrates a complete DevOps workflow for deploying a React application in a production-ready environment using Docker, Docker Compose, Jenkins CI/CD, Docker Hub, AWS EC2, and monitoring with Uptime Kuma.

📌 Project Overview

The main objective of this project was to:

Deploy a React application on an AWS EC2 instance
Dockerize the application
Automate deployment using Jenkins
Push Docker images to Docker Hub
Configure monitoring for application health status
Maintain separate Git branches for development and production workflow
🛠️ Technologies Used
React Application
Docker
Docker Compose
Jenkins
AWS EC2 (Ubuntu)
Docker Hub
Git & GitHub
Uptime Kuma Monitoring
📂 Repository Structure
devops-build/
│
├── build/
├── Dockerfile
├── docker-compose.yml
├── build.sh
├── deploy.sh
├── .gitignore
└── .dockerignore
⚙️ Docker Setup
Dockerfile

The application is served using Nginx inside a Docker container.

Build Docker Image
docker build -t devops-build .
Run Container
docker run -d -p 80:80 --name devops-container devops-build
🐳 Docker Compose

The project also uses Docker Compose for easier container management.

Start Application
docker compose up -d
Stop Application
docker compose down
📜 Shell Scripts
build.sh

Builds the Docker image.

#!/bin/bash

docker build -t devops-build .
deploy.sh

Deploys the application using Docker Compose.

#!/bin/bash

docker compose down

docker compose up -d --build
🌿 Git Branch Workflow

Two branches were maintained:

Branch	Purpose
master	Production
dev	Development
🐙 GitHub Repository
Repository URL

GitHub Repository

🐳 Docker Hub Repositories

Two Docker Hub repositories were created:

Development Repository
Production Repository

This setup helps separate development and production images properly.

🔄 Jenkins CI/CD Pipeline

Jenkins was configured to automate:

Cloning source code from GitHub
Building Docker images
Deploying containers automatically
Jenkins Pipeline Stages
Clone Repository
Build Docker Image
Deploy Application
☁️ AWS EC2 Deployment

The application was deployed on an AWS EC2 Ubuntu instance.

EC2 Configuration
Configuration	Value
Instance Type	t2.micro
OS	Ubuntu
Application Port	80
Jenkins Port	8080
Monitoring Port	3001
📊 Monitoring Setup

Application monitoring was implemented using Uptime Kuma.

Features
Application health monitoring
Downtime detection
Real-time monitoring dashboard
🌐 Live URLs
Application URL

Live Application

Jenkins Dashboard

Jenkins Dashboard

Monitoring Dashboard

Monitoring Dashboard

🚀 How to Run Locally
Clone Repository
git clone https://github.com/mngnesh/devops-build.git
cd devops-build
Build Docker Image
docker build -t devops-build .
Run Container
docker run -d -p 80:80 devops-build
Run Using Docker Compose
docker compose up -d
📸 Submission Includes
GitHub Repository
Dockerized Application
Docker Compose Configuration
Jenkins CI/CD Pipeline
AWS Deployment
Docker Hub Images
Monitoring Dashboard
Deployment Screenshots
✅ Project Status

✔ Application Successfully Deployed
✔ CI/CD Pipeline Working
✔ Monitoring Configured
✔ Dockerized Successfully
✔ Hosted on AWS EC2

🙌 Conclusion

This project helped in understanding the complete DevOps workflow from application deployment to automation and monitoring. It covers essential DevOps concepts such as containerization, CI/CD automation, cloud deployment, and health monitoring in a practical environment.
