terraform {
  required_version = ">= 1.14.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }

  backend "s3" {
    bucket               = "tf-core-tfstate-5616519818199"
    key                  = "07.02/lab01/terraform.tfstate"
    region               = "ap-northeast-2"
    encrypt              = true
    use_lockfile         = true
    workspace_key_prefix = "env:dev"
  }
}

provider "aws" {
  region = "ap-northeast-2"

  default_tags {
    tags = {
      Organization = local.org
      Project      = local.project
      Environment  = local.environment
      ManagedBy    = "Terraform"
    }
  }
}