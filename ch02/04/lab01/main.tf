resource "aws_iam_role" "instance" {
  name        = "${local.project}-iamrole-${local.iamrole.name}"
  assume_role_policy = local.iamrole.assume_role_policy
  
  
  tags = {
    Name = "${local.project}-iamrole-${local.iamrole.name}"
  }
}
resource "aws_iam_role_policy_attachment" "instance" {
    role       = aws_iam_role.instance.name
    policy_arn = local.iamrole.policy_arn
  }

resource "aws_iam_instance_profile" "instance" {
  name = "${local.project}-iamprofile-${local.iamrole.name}"
  role = aws_iam_role.instance.name

  tags = {
    Name = "${local.project}-${local.iamrole.name}"
  }
  
}

resource "aws_security_group" "instance" {
  name = "${local.project}-sg-instance"
  
  ingress {
    from_port   = local.instance.allow_access.port
    to_port     = local.instance.allow_access.port
    protocol    = "tcp"
    cidr_blocks = local.instance.allow_access.cidr_blocks
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${local.project}-sg-${local.instance.name}"
  }
}

resource "aws_instance" "ssm_test" {
  ami                    = local.instance.ami
  instance_type          = local.instance.instance_type
  associate_public_ip_address = local.instance.associate_public_ip_address
  
  vpc_security_group_ids = [aws_security_group.instance.id]
  iam_instance_profile = aws_iam_instance_profile.instance.name

  depends_on           = [aws_iam_role_policy_attachment.instance]

  tags = {
    Name = "${local.project}-instance-ssm-test"
  }
}