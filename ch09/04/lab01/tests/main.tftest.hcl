variables {
  instance_type = "t3.micro"
}

run "verify_instance_type" {
  command = plan

  assert {
    condition     = aws_instance.this.instance_type == "t3.micro"
    error_message = "instance_type이 t3.micro여야 한다."
  }
}

run "verify_naming" {
  command = plan

  assert {
    condition     = aws_instance.this.tags["Name"] == "tf-core-lab01-instance-web"
    error_message = "Name 태그가 네이밍 규칙과 일치해야 한다. 실제: ${aws_instance.this.tags["Name"]}" 
  }

  assert {
    condition     = aws_security_group.this.name == "tf-core-lab01-sg-instance-web"
    error_message = "SG 이름이 네이밍 규칙과 일치해야 한다."
  }

  assert {
    condition     = aws_iam_role.this.name == "tf-core-lab01-iamrole-instance-web"
    error_message = "IAM Role 이름이 네이밍 규칙과 일치해야 한다."
  }
}

run "verify_sg_ingress" {
  command = plan

  assert {
    condition     = one(aws_security_group.this.ingress).from_port == 80
    error_message = "SG ingress 포트가 80이어야 한다."
  }

  assert {
    #
    condition     = one(aws_security_group.this.ingress).protocol == "tcp"
    error_message = "SG ingress 프로토콜이 tcp여야 한다."
  }
}

run "verify_variable_override" {
  command = plan

  variables {
    instance_type = "t3.small"
  }

  assert {
    condition     = aws_instance.this.instance_type == "t3.small"
    error_message = "override된 instance_type이 t3.small이어야 한다."
  }
}

run "reject_invalid_instance_type" {
  command = plan

  variables {
    instance_type = "t1.micro"
  }

  expect_failures = [
    var.instance_type,
  ]
}