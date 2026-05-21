# lab04와 구조는 동일
# 차이점: 리소스 이름이 "instance" → "this" 로 변경
# → 모듈화 대비 (모듈에선 this가 관례)

resource "aws_iam_role" "this" {
  name               = "${local.project}-iamrole-${local.iamrole.name}"
  assume_role_policy = local.iamrole.assume_role_policy

  tags = {
    Name = "${local.project}-iamrole-${local.iamrole.name}"
  }
}

resource "aws_iam_instance_profile" "this" {
  name = "${local.project}-iamprofile-${local.iamrole.name}"
  role = aws_iam_role.this.name

  tags = {
    Name = "${local.project}-iamprofile-${local.iamrole.name}"
  }
}

resource "aws_iam_role_policy_attachment" "this" {
  role       = aws_iam_role.this.name
  policy_arn = local.iamrole.policy_arn
}

resource "aws_security_group" "this" {
  name   = "${local.project}-sg-instance-${local.instance.name}"
  # lab04와 달리 vpc_id 명시 → default VPC가 아닌 특정 VPC 지정 가능
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
    Name = "${local.project}-sg-instance-${local.instance.name}"
  }
}

resource "aws_instance" "this" {
  ami                         = local.instance.ami
  instance_type               = local.instance.instance_type
  associate_public_ip_address = local.instance.associate_public_ip_address
  # lab04와 달리 subnet_id 명시 → 어느 서브넷에 생성할지 지정
  subnet_id                   = local.instance.subnet_id

  vpc_security_group_ids = [aws_security_group.this.id]
  iam_instance_profile   = aws_iam_instance_profile.this.name

  depends_on = [aws_iam_role_policy_attachment.this]

  tags = {
    Name = "${local.project}-instance-${local.instance.name}"
  }
}