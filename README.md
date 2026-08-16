# DevOps Build - Application Deployment



## Project Overview



This project demonstrates the deployment of a React-based web application using Docker, Jenkins CI/CD, Docker Hub, AWS EC2, Prometheus, and Blackbox Exporter.



The application is containerized and deployed to an AWS EC2 instance. Jenkins automatically builds Docker images and pushes them to Docker Hub based on the Git branch.



---



## Technology Stack



- Git \& GitHub

- Docker

- Docker Compose

- Jenkins

- Jenkins Multibranch Pipeline

- Docker Hub

- AWS EC2

- Prometheus

- Blackbox Exporter

- Nginx

- React



---



## Project Architecture



```text

&#x20;                        GitHub

&#x20;                   dev / master

&#x20;                        |

&#x20;                        v

&#x20;                      Jenkins

&#x20;                   Multibranch

&#x20;                     Pipeline

&#x20;                   /          \\

&#x20;                  /            \\

&#x20;               dev              master

&#x20;                |                 |

&#x20;                v                 v

&#x20;         Docker Hub          Docker Hub

&#x20;         mngnesh/dev        mngnesh/prod

&#x20;                                 |

&#x20;                                 v

&#x20;                             AWS EC2

&#x20;                             t3.micro

&#x20;                                 |

&#x20;                             Docker

&#x20;                                 |

&#x20;                        +--------+--------+

&#x20;                        |                 |

&#x20;                   Application       Monitoring

&#x20;                     :80              Prometheus

&#x20;                                        |

&#x20;                                 Blackbox Exporter

&#x20;                                        |

&#x20;                                 Health Check

````



---



## Application



The application is a React-based OnlineShop application.



The application is served through Nginx inside a Docker container.



### Application Port



```text

Container Port: 80

EC2 Port:       80

```



The deployed application is publicly accessible through the EC2 public IPv4 address.



---



# Docker



## Dockerfile



The application is packaged into a Docker image using the project `Dockerfile`.



The Docker image contains the application and Nginx configuration required to serve the production build.



## Docker Compose



The project also contains:



```text

docker-compose.yml

```



for container-based application deployment.



## Build Script



```text

build.sh

```



Builds the Docker image.



## Deployment Script



```text

deploy.sh

```



Stops the existing application container and starts the new container on port 80.



---



# Git Branch Strategy



The project uses separate branches for development and production.



```text

dev

&#x20;|

&#x20;| Jenkins build

&#x20;v

mngnesh/dev:latest

```



and:



```text

master

&#x20;|

&#x20;| Jenkins build

&#x20;v

mngnesh/prod:latest

```



The `dev` branch is used for development builds, while the `master` branch represents the production image.



---



# Jenkins CI/CD



Jenkins is configured as a Multibranch Pipeline connected to the GitHub repository.



Repository:



```text

https://github.com/mngnesh/devops-build

```



The pipeline is defined in:



```text

Jenkinsfile

```



## Pipeline Stages



The Jenkins pipeline performs the following operations:



1\. Checkout source code

2\. Determine the Git branch

3\. Determine the Docker repository

4\. Build the Docker image

5\. Tag the Docker image

6\. Login to Docker Hub using Jenkins credentials

7\. Push the image to Docker Hub

8\. Clean unused Docker images



### Branch Mapping



| Git Branch | Docker Hub Repository |

| ---------- | --------------------- |

| `dev`      | `mngnesh/dev`         |

| `master`   | `mngnesh/prod`        |



---



# Docker Hub



The Docker images are stored in Docker Hub.



## Development Image



```text

mngnesh/dev:latest

```



## Production Image



```text

mngnesh/prod:latest

```



The production image is deployed to the AWS EC2 instance.



---



# AWS EC2 Deployment



The production application is deployed on an AWS EC2 instance running Ubuntu.



### Instance



```text

Instance Type: t3.micro

Operating System: Ubuntu

```



The application is deployed using Docker.



### Production Container



```text

Container Name: devops-build-app

Image: mngnesh/prod:latest

Port: 80:80

```



The container is configured to restart automatically.



---



# Monitoring



The deployed application is monitored using open-source monitoring tools.



## Prometheus



Prometheus is used to collect and evaluate monitoring metrics.



Prometheus runs inside Docker on:



```text

Port: 9090

```



## Blackbox Exporter



Blackbox Exporter is used to perform an HTTP health check against the application.



The monitoring flow is:



```text

Application

&#x20;    |

&#x20;    v

Blackbox Exporter

&#x20;    |

&#x20;    v

probe\_success

&#x20;    |

&#x20;    v

Prometheus

```



### Health Status



```text

probe\_success = 1

```



means the application is responding successfully.



```text

probe\_success = 0

```



means the application is not responding successfully.



---



# Application Down Alert



Prometheus contains an alert rule named:



```text

ApplicationDown

```



The alert condition is:



```text

probe\_success == 0

```



The alert remains active for 30 seconds before firing.



When the application becomes unavailable:



```text

ApplicationDown = firing

```



When the application recovers:



```text

ApplicationDown = inactive

```



The alert was tested by intentionally stopping the application container and verifying that Prometheus detected the failure.



The application was then restarted and the health check returned to:



```text

probe\_success = 1

```



---



# Docker Containers



The EC2 instance runs the following containers:



```text

devops-build-app

blackbox-exporter

prometheus

```



### Application



```text

mngnesh/prod:latest

80:80

```



### Blackbox Exporter



```text

prom/blackbox-exporter:latest

9115

```



### Prometheus



```text

prom/prometheus:latest

9090

```



---



# Deployment Flow



The complete deployment flow is:



```text

Developer

&#x20;   |

&#x20;   v

GitHub

&#x20;   |

&#x20;   v

Jenkins

&#x20;   |

&#x20;   +-------------------+

&#x20;   |                   |

&#x20;  dev               master

&#x20;   |                   |

&#x20;   v                   v

Docker Hub          Docker Hub

mngnesh/dev        mngnesh/prod

&#x20;                       |

&#x20;                       v

&#x20;                    AWS EC2

&#x20;                       |

&#x20;                       v

&#x20;                 Docker Container

&#x20;                       |

&#x20;                       v

&#x20;                 OnlineShop :80

&#x20;                       |

&#x20;                       v

&#x20;               Blackbox Exporter

&#x20;                       |

&#x20;                       v

&#x20;                  Prometheus

&#x20;                       |

&#x20;                       v

&#x20;                ApplicationDown

```



---



# Project Files



```text

devops-build/

│

├── .dockerignore

├── Dockerfile

├── Jenkinsfile

├── build.sh

├── deploy.sh

├── docker-compose.yml

├── README.md

│

└── screenshots/

```



---



# Screenshots



The project contains screenshots demonstrating the deployment and CI/CD process.



```text

screenshots/

├── 01-github-repository.png

├── 02-github-branches.png

├── 03-dockerhub-dev-image.png

├── 04-dockerhub-prod-image.png

├── 05-jenkins-dashboard.png

├── 06-jenkins-dev-success.png

├── 07-jenkins-master-success.png

├── 08-aws-ec2-instance.png

├── 09-ec2-docker-container.png

├── 10-deployed-application.png

├── 11-prometheus-dashboard.png

├── 12-prometheus-alert-firing.png

└── 13-prometheus-alert-recovered.png

```



---



# Verification



The deployment was verified through the following tests:



\* Docker image successfully built

\* Docker images successfully pushed to Docker Hub

\* Jenkins `dev` pipeline completed successfully

\* Jenkins `master` pipeline completed successfully

\* Production Docker image successfully pulled on EC2

\* Production container successfully started

\* Application successfully accessed through the EC2 public IP

\* Prometheus successfully started

\* Blackbox Exporter successfully started

\* HTTP health check returned `probe\_success = 1`

\* Application failure was detected by Prometheus

\* `ApplicationDown` alert successfully entered the `firing` state

\* Application was restarted successfully

\* `probe\_success` returned to `1`

\* Alert cleared after application recovery



---



# Conclusion



This project demonstrates a complete DevOps deployment workflow using GitHub, Jenkins CI/CD, Docker, Docker Hub, AWS EC2, Prometheus, and Blackbox Exporter.



The application is containerized, continuously built through Jenkins, published to Docker Hub, deployed to AWS EC2, and monitored using an open-source monitoring stack.



```



After pasting and saving, \*\*don't commit yet\*\*. Tell me `saved`, and we'll check the README and then add the `screenshots` folder/files to Git.





