# resource "aws_lb_target_group_attachment" "this" {
#   target_group_arn = "arn:aws:elasticloadbalancing:..."
#   target_id        = aws_instance.this.id
#   port             = 80
# }
resource "aws_lb_target_group_attachment" "this" {
  target_group_arn = local.lb.target_group_arn
  target_id        = aws_instance.this.id
  port             = local.instance.allow_access.port
}

resource "aws_instance" "this" {
  ami                         = local.instance.ami
  instance_type               = local.instance.instance_type
  subnet_id                   = local.instance.subnet_id
  associate_public_ip_address = local.instance.associate_public_ip_address
  iam_instance_profile        = local.instance.iam_instance_profile
  vpc_security_group_ids      = [aws_security_group.this.id]

  tags = {
    Name = "${local.namespace}-instance-${local.instance.name}"
  }
}

resource "aws_security_group" "this" {
  name   = "${local.namespace}-sg-instance-${local.instance.name}"
  vpc_id = local.vpc_id

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
    Name = "${local.namespace}-sg-instance-${local.instance.name}"
  }
}