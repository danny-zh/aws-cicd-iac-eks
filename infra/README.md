# Infrastructure as Code (IaC) for EKS Cluster

This directory contains Terraform code to provision an Amazon EKS cluster and its supporting infrastructure on AWS.

## Overview

The infrastructure code provisions:

- Amazon VPC with public and private subnets
- Amazon EKS cluster with managed node groups
- Security groups and IAM roles
- AWS Load Balancer Controller

## Directory Structure

```
infra/
├── modules/                # Local Terraform modules
├── scripts/                # Helper scripts
├── eks.tf                  # EKS cluster configuration
├── lbcontroller.tf         # AWS Load Balancer Controller (commented)
├── main.tf                 # Main Terraform configuration
├── outputs.tf              # Output values
├── providers.tf            # Provider configuration
├── variables.tf            # Input variables
├── vpc.tf                  # VPC configuration
├── infra-build-buildspec.yml  # AWS CodeBuild spec for planning
└── infra-deploy-buildspec.yml # AWS CodeBuild spec for deployment
```

## Prerequisites

- [Terraform](https://www.terraform.io/downloads.html) >= 1.0.0
- AWS CLI configured with appropriate credentials
- AWS account with permissions to create EKS clusters

## Configuration

The infrastructure can be customized through variables defined in `variables.tf`:

| Variable | Description | Default |
|----------|-------------|---------|
| `cluster_name` | Name of the EKS cluster | `eks-cluster-demo` |
| `cluster_version` | Kubernetes version | `1.31` |
| `ami_release_version` | EKS AMI release version | `1.31.3-20250103` |
| `vpc_cidr` | CIDR block for the VPC | `10.140.0.0/16` |
| `vpc_private_subnets_count` | Number of private subnets | `2` |
| `vpc_public_subnets_count` | Number of public subnets | `2` |
| `aws_instance_type` | EC2 instance type for nodes | `t3a.small` |

## Usage

### Local Deployment

1. Initialize Terraform:
   ```bash
   terraform init
   ```

2. Plan the deployment:
   ```bash
   terraform plan -out=tfplan
   ```

3. Apply the changes:
   ```bash
   terraform apply tfplan
   ```

4. To destroy the infrastructure:
   ```bash
   terraform destroy
   ```

### CI/CD Pipeline

The repository includes AWS CodeBuild specifications for CI/CD:

- `infra-build-buildspec.yml`: Validates and plans Terraform changes
- `infra-deploy-buildspec.yml`: Applies the Terraform plan

## Architecture

The infrastructure follows AWS best practices:

1. **Networking**:
   - VPC with public and private subnets across multiple AZs
   - NAT Gateway for outbound internet access from private subnets
   - Internet Gateway for public subnet access

2. **EKS Cluster**:
   - EKS cluster with managed node groups
   - VPC CNI addon with network policy support
   - Public endpoint with RBAC authentication

3. **Node Groups**:
   - Managed node group with t3a.small instances
   - Auto-scaling configuration (min: 1, max: 2, desired: 2)
   - IAM roles with least privilege

## Security Features

- Private subnets for worker nodes
- Security groups with least privilege access
- IAM roles with specific permissions
- Network ACLs for subnet protection

## Tagging Strategy

Resources are tagged with:
- `created-by`: Creator identifier
- `env`: Environment name with unique suffix
- Kubernetes-specific tags for auto-discovery

## Outputs

After successful deployment, the following outputs are available:
- EKS cluster name and endpoint
- VPC ID and subnet IDs
- Node group details

## Related Components

This infrastructure supports the application deployment defined in the `appchart` directory using Helm.

#Add this line to trigeer change in infra