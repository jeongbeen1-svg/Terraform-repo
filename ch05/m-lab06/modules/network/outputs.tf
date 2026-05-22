output "vpc" {
  value = {
    (local.vpc.name) = {
      id = aws_vpc.this.id
    }
  }
}

output "subnet" {
  value = {
    (local.subnet_public[0].name) = {
      id = aws_subnet.public_0.id
    }

    (local.subnet_public[1].name) = {
      id = aws_subnet.public_1.id
    }

    (local.subnet_private[0].name) = {
      id = aws_subnet.private_0.id
    }

    (local.subnet_private[1].name) = {
      id = aws_subnet.private_1.id
    }
  }
}