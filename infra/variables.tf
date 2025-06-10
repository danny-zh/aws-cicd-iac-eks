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
  default     = "t3a.small"
  description = "t2 micro free eligible tier."

  validation {
    condition     = var.aws_instance_type == "t3a.small"
    error_message = "The instance allowed is t3a.small"

  }

}

# Variables for LB controller

# tflint-ignore: terraform_unused_declarations
# variable "eks_cluster_id" {
#   description = "EKS cluster name"
#   type        = string
# }

# tflint-ignore: terraform_unused_declarations
variable "eks_cluster_version" {
  description = "EKS cluster version"
  type        = string
}


# # tflint-ignore: terraform_unused_declarations
variable "addon_context" {
  description = "Addon context that can be passed directly to blueprints addon modules"
  type        = any
}

# tflint-ignore: terraform_unused_declarations
# variable "tags" {
#   description = "Tags to apply to AWS resources"
#   type        = any
# }

# tflint-ignore: terraform_unused_declarations
# variable "resources_precreated" {
#   description = "Have expensive resources been created already"
#   type        = bool
# }

variable "load_balancer_controller_chart_version" {
  description = "The chart version of aws-load-balancer-controller to use"
  type        = string
  # renovate-helm: depName=aws-load-balancer-controller
  default = "1.12.0"
}
