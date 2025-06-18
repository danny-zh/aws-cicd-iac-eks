
# Filter out local zones, which are not currently supported 
# with managed node groups
data "aws_availability_zones" "available" {
  filter {
    name   = "opt-in-status"
    values = ["opt-in-not-required"]
  }
}

# Define local variables
locals {
  tags = {
    created-by = "dherrra@site.me"
    env        = "${var.cluster_name}-${random_string.id.result}"
  }
  cluster_name = "${var.cluster_name}-${random_string.id.result}"
}

# Generate random suffix for cluster name
resource "random_string" "id" {
  length  = 5
  special = false
  upper   = false
  numeric = false
}

# # Generate k8s 
# provider "kubernetes" {
#   host                   = module.eks.cluster_endpoint
#   cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
#   exec {
#     api_version = "client.authentication.k8s.io/v1beta1"
#     args        = ["eks", "get-token", "--cluster-name", module.eks.cluster_name]
#     command     = "aws"
#   }
# }

# # data "kubernetes_service" "nginx" {
# #   depends_on = [helm_release.nginx]
# #   metadata {
# #     name = "nginx"
# #   }
# # }

# # data "kubernetes_service" "lbccontroller" {
# #   depends_on = [helm_release.lbccontroller]
# #   metadata {
# #     name = "lbccontroller"
# #   }
# # }