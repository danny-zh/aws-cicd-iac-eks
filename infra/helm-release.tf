# Configure Helm provider to interact with EKS cluster
# Uses cluster endpoint and certificate from EKS module
# Sets up authentication using AWS CLI command
provider "helm" {
  kubernetes {
    host                   = module.eks.cluster_endpoint
    cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
    exec {
      api_version = "client.authentication.k8s.io/v1beta1"
      args        = ["eks", "get-token", "--cluster-name", module.eks.cluster_name]
      command     = "aws"
    }
  }
}

# Install AWS Load Balancer Controller using Helm
# Depends on EKS cluster being created first
# Uses official AWS chart repository
resource "helm_release" "aws_lb_controller" {
  depends_on = [module.eks]
  name       = "aws-load-balancer-controller"
  chart      = "aws-load-balancer-controller"
  repository = "https://aws.github.io/eks-charts"
  version    = "1.12.0"
  namespace  = "kube-system"
  wait       = true

  # Set cluster name for the controller
  set {
    name  = "clusterName"
    value = module.eks.cluster_name
  }

  # Configure service account name
  set {
    name  = "serviceAccount.name"
    value = "aws-load-balancer-controller-sa"
  }

  # Add IAM role annotation to service account
  # Uses role ARN from EKS blueprints addon module
  set {
    name  = "serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
    value = module.eks_blueprints_addons.aws_load_balancer_controller.iam_role_arn
  }
}

# Install local chart version
resource "helm_release" "appchart" {
  name       = "appchart"
  chart      = "../appchart"
  namespace  = "default"
  wait       = true
  lint       = true 
  upgrade_install =  true
  version = "0.1.0"
  depends_on = [helm_release.aws_lb_controller]
  values = [
    file("../secret_data.yml")
  ]
}