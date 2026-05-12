terraform {
  required_version = ">=1.14.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>6.0"
    }
  }
}

provider "aws" {
  region = "ap-northeast-2"
}

locals {
  vpc_cidr_block = "10.0.0.0/16"  
}

resource "aws_vpc" "main" {
  cidr_block           = local.vpc_cidr_block
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "tf-core-lab02-vpc-main"
  }
}

output "vpc" {
  value = {
    id  = aws_vpc.main.id
    arn = aws_vpc.main.arn
  }
}
