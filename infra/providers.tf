terraform {
  required_version = ">= 0.12" #Required terraform version
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">=5.63.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = ">= 2.17.0"
    }
    random = {
      source  = "hashicorp/random"
      version = ">= 3.6.1"
    }
  }

  backend "s3" {
    bucket  = "aws-cicd-iac-eks"
    key     = "infra/testing/terraform.tfstate"
    region  = "us-east-1"
    encrypt = true
  }

}

provider "random" {}


