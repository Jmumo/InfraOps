# Software Engineer Test

[![CI-CD](https://github.com/ajharry69/kyosk-test/actions/workflows/ci-cd.yml/badge.svg)](https://github.com/Jmumo/InfraOps/blob/main/.github/workflows/maven.yml)

A simple spring boot application that provides an API endpoint for listing books.

## Building and Running

### Using (Plain) Docker

#### What you will need

1. [Install docker][docker-installation-url].

#### How To Run Locally

. the command is running on a [Unix-based system](https://en.wikipedia.org/wiki/List_of_Unix_systems).

#### Start the application

Run Docker Compose file for the MongoDB then run the App

### Using Kubernetes (k8s)

#### What you will need

1. [Install docker][docker-installation-url].
2. [Install kubectl](https://kubernetes.io/docs/reference/kubectl/).
   1. [Install for linux](https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/).
   2. [Install for macOS](https://kubernetes.io/docs/tasks/tools/install-kubectl-macos/).
   3. [Install for Windows](https://kubernetes.io/docs/tasks/tools/install-kubectl-windows/).
3. [Install minikube](https://minikube.sigs.k8s.io/docs/start/).


```

#### Apply k8s manifests

Cd to the K8s folder and run this comand 

```bash
kubectl apply -f . 
```


## CI/CD

Continuous Integration (CI) & Continuous Deployment (CD) pipeline is running on GitHub Actions.

### How it works

When changes have been pushed to the `main` branch or pull request is open to the `main` branch, the **CI** job is run.
In the CI phase,

1. the repository is first checked out (cloned locally).
2. the mongo db versions (7 & 8) are set up and started. This will be used later.
3. Java version 17 from the temurin distribution is set up.
   Our application being a java application, will need it for the subsequent steps.
4. Gradle is configured for optimal use of GitHub Actions resources through caching of downloaded dependencies.
5. Build the application using the Gradle wrapper script to ensure everything in terms of application configuration is
   in order.
6. Run the automated tests included in the application using the Gradle wrapper script to ensure all the components are
   in working order.

When a new release tag with the pattern `v*.*.*` is pushed, the **CD** job is run.
But before the CD phase is run, the **CI** phase must run successfully to ensure we do not deploy broken docker images.

A new release tag can be cut as follows:

```bash
git tag --annotate v1.0.0 --message "Version 1.0.0"
```

and pushed to GitHub as follows:

```bash
git push --tags
```

