variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
  default     = "dherrera-eks-cluster"
}

variable "cluster_version" {
  description = "EKS cluster version."
  type        = string
  default     = "1.31"
}

variable "ami_release_version" {
  description = "Default EKS AMI release version for node groups"
  type        = string
  default     = "1.31.3-20250103"
}

variable "vpc_cidr" {
  description = "Defines the CIDR block used on Amazon VPC created for Amazon EKS."
  type        = string
  default     = "10.140.0.0/16"
}

variable "vpc_private_subnets_count" {
  description = "Defines the number of private subnets used on Amazon VPC created for Amazon EKS."
  type        = number
  default     = 2
}

variable "vpc_public_subnets_count" {
  description = "Defines the number of public subnets used on Amazon VPC created for Amazon EKS."
  type        = number
  default     = 2
}

variable "aws_instance_type" {
  type        = string
  default     = "t3a.small"
  description = "t2 micro free eligible tier."

  validation {
    condition     = var.aws_instance_type == "t3a.small"
    error_message = "The instance allowed is t3a.small"

  }

}

variable "load_balancer_controller_chart_version" {
  description = "The chart version of aws-load-balancer-controller to use"
  type        = string
  # renovate-helm: depName=aws-load-balancer-controller
  default = "1.12.0"
}

variable "cluster_min_size" {
  description = "The minimum size of the managed nodes EKS cluster"
  type        = number
  default     = 1
}

variable "cluster_max_size" {
  description = "The maximum size of the managed nodes EKS cluster"
  type        = number
  default     = 2
}

variable "cluster_desired_size" {
  description = "The desired size of the managed nodes EKS cluster"
  type        = number
  default     = 2
}