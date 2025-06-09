variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
  default     = "eks-cluster-demo"
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
  default     = "t2.micro"
  description = "t2 micro free eligible tier."

  validation {
    condition     = var.aws_instance_type == "t2.micro"
    error_message = "The instance allowed is t2.micro"

  }

}