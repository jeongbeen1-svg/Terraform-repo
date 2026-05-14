resource "aws_iam_role" "this" {
  name               = "${local.namespace}-iamrole-${local.iamrole.name}"
  assume_role_policy = local.iamrole.assume_role_policy

  tags = {
    Name = "${local.namespace}-iamrole-${local.iamrole.name}"
  }
}

resource "aws_iam_instance_profile" "instance" {
  name = "${local.namespace}-iamprofile-instance-minimal"
  role = aws_iam_role.this.name
}

resource "aws_iam_instance_profile" "this" {
  name = "${local.namespace}-iamprofile-${local.iamrole.name}"
  role = aws_iam_role.this.name

  tags = {
    Name = "${local.namespace}-iamprofile-${local.iamrole.name}"
  }
}