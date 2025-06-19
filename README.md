# EKS Application Deployment Project

This repository contains a complete solution for deploying a FastAPI application to Amazon EKS using Terraform, Helm, and AWS services.

## Project Structure

- [`app/`](app/README.md) - FastAPI backend application with Docker containerization
- [`appchart/`](appchart/README.md) - Helm chart for Kubernetes deployment
- [`infra/`](infra/README.md) - Terraform code for AWS infrastructure provisioning

## Overview

This project demonstrates a complete CI/CD pipeline for deploying a containerized application to Amazon EKS. It includes:

1. A FastAPI backend application
2. Infrastructure as Code using Terraform
3. Kubernetes deployment using Helm charts
4. CI/CD pipeline configurations

## Prerequisites

- AWS CLI configured with appropriate permissions
- Terraform >= 1.0.0
- Helm >= 3.0.0
- kubectl
- Docker

## Quick Start

### 1. Deploy Infrastructure

```bash
cd infra
terraform init
terraform apply
```

### 2. Configure kubectl

```bash
make eks-update
```

### 3. Build and Push Application

```bash
cd app
# Follow instructions in app/README.md
```

### 4. Deploy Application

```bash
# Create a secret_data.yml file with your configuration
make helm-install
```

## Makefile Commands

The project includes a Makefile with the following commands:

- `make helm-install` - Install the application using Helm
- `make helm-upgrade` - Upgrade an existing installation
- `make helm-uninstall` - Remove the application
- `make eks-update` - Update kubeconfig for EKS access

## CI/CD Pipeline

The repository includes AWS CodeBuild specifications for CI/CD:

- `app/app-buildspec.yml` - Builds and pushes the Docker image
- `infra/infra-build-buildspec.yml` - Plans Terraform changes
- `infra/infra-deploy-buildspec.yml` - Applies Terraform changes

## Security

- IAM roles follow the principle of least privilege
- Network security follows AWS best practices

## License

This project is licensed under the terms of the [Apache License 2.0](https://www.apache.org/licenses/LICENSE-2.0)

## Component Readme

For more information about the components, refer to the README files in each directory:

- [Application Documentation](app/README.md)
- [Helm Chart Documentation](appchart/README.md)
- [Infrastructure Documentation](infra/README.md)

## Git Screnshots

![image](https://github.com/user-attachments/assets/b008e47f-19f8-4910-997d-187eb6a65d7e)

## App Screnshots

![image](https://github.com/user-attachments/assets/0f281268-9251-4180-9f87-8f073c96a8b9)

![image](https://github.com/user-attachments/assets/f5b26916-4d2f-45e5-88ad-47b25d19cce2)

## Infra Screnshots

![image](https://github.com/user-attachments/assets/bcba5d1e-95fb-4325-9212-e0c968b243ea)

![image](https://github.com/user-attachments/assets/80e25d56-efea-487e-94be-3ecde28c0fad)

![image](https://github.com/user-attachments/assets/c8b98913-24ed-49c4-9842-9ff12f3ea9b1)

![image](https://github.com/user-attachments/assets/78d83748-3dad-4993-89de-18ed7fa59a59)

![image](https://github.com/user-attachments/assets/71b17186-d976-4a48-bfe0-4e33f67f95db)


## Codepipeline screenshots

![image](https://github.com/user-attachments/assets/a1f01891-61ea-4951-8d23-a6333b05c877)

![image](https://github.com/user-attachments/assets/81efc855-0023-48a4-b7c6-d726f65673cf)

![image](https://github.com/user-attachments/assets/4f5dafa2-9951-47dd-a68a-197dfd3a8a95)



