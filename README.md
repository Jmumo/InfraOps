# InfraOps Application

InfraOps is a microservice application designed for managing infrastructure operations, built with Spring Boot and deployed in a Kubernetes environment.

## Table of Contents

- [Project Overview](#project-overview)
- [Features](#features)
- [Technologies Used](#technologies-used)
- [Environment Variables](#environment-variables)
- [Setup Instructions](#setup-instructions)
- [Kubernetes Deployment](#kubernetes-deployment)
- [Usage](#usage)
- [License](#license)
- [CI/CD Pipeline](#ci/cd-pipeline)
- [Contributing](#contributing)

---

## Project Overview

This project demonstrates the deployment of a Spring Boot application connected to a MongoDB database using Kubernetes. It leverages Kubernetes secrets for managing sensitive information like database credentials.

---

## Features

- RESTful APIs for resource management.
- Integration with MongoDB.
- Deployment on Kubernetes with LoadBalancer service.
- Secrets management for sensitive data.

---

## Technologies Used

- **Spring Boot**: Backend framework.
- **MongoDB**: NoSQL database.
- **Docker**: Containerization of the application.
- **Kubernetes**: Deployment and orchestration.
- **LoadBalancer**: External access to the service.

---

## Environment Variables

The application uses the following environment variables. These should be configured via Kubernetes Secrets:

| Variable        | Description                    |
|-----------------|--------------------------------|
| `MONGO_USER`    | MongoDB username              |
| `MONGO_PASSWORD`| MongoDB password              |
| `MONGO_DB_URL`  | MongoDB connection URL        |

---

## Setup Instructions

1. **Clone the repository**:
    ```bash
    git clone https://github.com/Jmumo/infraops.git
    cd infraops
    ```

2. **Build the Docker image**:
    ```bash
    docker build -t mjupiter/infraops:latest .
    ```

3. **Push the Docker image to a registry**:
    ```bash
    docker push mjupiter/infraops:latest
    ```

4. **Create Kubernetes Secrets** for database credentials:
    ```bash
    kubectl create secret generic db-credentials \
      --from-literal=DB_USER=your_user \
      --from-literal=DB_PASSWORD=your_password
    ```

5. **Apply the Kubernetes configuration**:
    ```bash
    kubectl apply -f app-deployment.yaml
    ```

---

## Kubernetes Deployment

The `app-deployment.yaml` defines:

- A **Deployment** for the Spring Boot app.
- A **Service** of type `LoadBalancer` for external access.
- Environment variables sourced from Kubernetes Secrets.

---

## Usage

1. Access the application via the LoadBalancer IP:
    ```bash
    curl http://<EXTERNAL-IP>/books
    ```

2. Example API usage:
    ```bash
    curl -X POST -H "Content-Type: application/json" \
    -d '{"title": "1984", "author": "George Orwell"}' \
    http://<EXTERNAL-IP>/books
    ```

---

## License

This project is licensed under the [MIT License](LICENSE).

---

## CI/CD Pipeline

The project includes a GitHub Actions workflow to automate testing, building, and pushing Docker images. The workflow:

1. **Builds and Tests** the Spring Boot application using Gradle.
2. **Builds the Docker Image**.
3. **Pushes the Image** to Docker Hub.

### Workflow Configuration
```yaml
name: InfraOps CI/CD

on:
  push:
    branches:
      - main

jobs:
  build-deploy:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout Code
        uses: actions/checkout@v2

      - name: Setup Java 17
        uses: actions/setup-java@v3
        with:
          distribution: 'corretto'
          java-version: 17

      - name: Run Gradle Tests
        uses: gradle/gradle-build-action@v2
        with:
          tasks: clean test

      - name: Build Docker Image
        uses: docker/setup-buildx-action@v1
        with:
          context: .
          dockerfile: Dockerfile
          tags: ${{ secrets.DOCKER_HUB_USERNAME }}/infraops:latest

      - name: Login to DockerHub
        uses: docker/login-action@v1
        with:
          username: ${{ secrets.DOCKER_HUB_USERNAME }}
          password: ${{ secrets.DOCKER_HUB_ACCESS_TOKEN }}

      - name: Push Docker Image
        uses: docker/build-push-action@v2
        with:
          context: .
          dockerfile: Dockerfile
          push: true
          tags: ${{ secrets.DOCKER_HUB_USERNAME }}/infraops:latest