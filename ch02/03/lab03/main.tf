resource "aws_iam_role" "instance" {
  name        = "${local.project}-iamrole-instance"
  description = "${local.project} security group for ec2 instance"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
  })
  
  tags = {
    Name = "${local.project}-iamrole-instance"
  }
}
resource "aws_iam_role_policy_attachment" "instance" {
    role       = aws_iam_role.instance.name
    policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  }

resource "aws_iam_instance_profile" "instance" {
  name = "${local.project}-iamprofile-instance"

  role = aws_iam_role.instance.name

  tags = {
    Name = "${local.project}-iamprofile-instance"
  }
  
}

resource "aws_security_group" "instance" {
  name = "${local.project}-sg-instance"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${local.project}-sg-instance"
  }
}

resource "aws_instance" "instance" {
  ami                    = "ami-0c003e98ceffee43e"
  instance_type          = "t3.micro"
  vpc_security_group_ids = [aws_security_group.instance.id]

  iam_instance_profile = aws_iam_instance_profile.instance.name
  depends_on           = [aws_iam_role_policy_attachment.instance]

  tags = {
    Name = "${local.project}-instance-micro"
  }
}