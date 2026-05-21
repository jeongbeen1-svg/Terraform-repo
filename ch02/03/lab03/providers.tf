# 제공자 버전
terraform {
  required_version = ">=1.14.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 6.0"
    }
  }
}
# CSP 제공 종류
provider "aws" {
  region = "ap-northeast-2"

  # aws로 만드는 리소스들은 Project, ManagedBy 태그를 받음
  default_tags {
    tags = {
      Project   = "tf-core-lab01"
      ManagedBy = "Terraform"
    }
  }
}
