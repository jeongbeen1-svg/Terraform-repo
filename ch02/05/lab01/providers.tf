# 테라폼 버전
terraform {
  # 요구하는 버전값은 1.14와 같거나 높아야 함
  required_version = ">=1.14.0"

  # 요구하는 제공 소스는 hashicorp terraform
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

# csp 타입
provider "aws" {
  region = "ap-northeast-2"

  # lab04와 달리 하드코딩 대신 local 참조
      # → 프로젝트명 변경 시 locals.tf 한 곳만 수정하면 됨
  default_tags {
    tags = {
      Project   = local.project
      ManagedBy = "Terraform"
    }
  }
}