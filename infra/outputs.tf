# output "environment_variables" {
#   description = "Environment variables to be added to the IDE shell"
#   value = {
#     LBC_CHART_VERSION = var.load_balancer_controller_chart_version
#     LBC_ROLE_ARN      = module.eks_blueprints_addons.aws_load_balancer_controller.iam_role_arn
#   }
# }

output "eks_cluster_region" {
  value = var.region
  description = "The AWS region where the EKS cluster is deployed"
}

output "eks_cluster_name" {
  value = module.eks.cluster_name
}

output "eks_cluster_version" {
  value = module.eks.cluster_version
}

output "eks_oidc_provider_arn" {
  value = module.eks.oidc_provider_arn
}

output "aws_eks_cluster_endpoint" {
  value = module.eks.cluster_endpoint
}