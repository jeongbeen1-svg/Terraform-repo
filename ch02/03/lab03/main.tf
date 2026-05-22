# iam 역할 선언 이름:인스턴스
resource "aws_iam_role" "instance" {
  # local의 project 이름을 받는 iamrole-instance 생성
  name        = "${local.project}-iamrole-instance"
  description = "${local.project} security group for ec2 instance"

  # 역할 정책 부여
  # EC2가 이 역할을 사용할 수 있도록 신뢰 정책 정의
  # jsonencode() → HCL 객체를 JSON 문자열로 변환해주는 내장함수
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      # sts:AssumeRole → "이 역할을 사용하겠다" 고 요청하는 행위
      # # AdministratorAccess 권한이 존재 하더라도, AssumeRole로 접근 필수적
      Action = "sts:AssumeRole"
      # 허용을 해줌
      Effect = "Allow"


      Principal = {
        #IAM Role 생성 시, EC2 Profile 역할로 사용됨을 지정
        Service = "ec2.amazonaws.com"
      }
    }]
  })

  # 이름 태그는 = "lab03-iamrole-instance"
  tags = {
    Name = "${local.project}-iamrole-instance"
  }
}

# 위에서 생성한 IAM roel 정책을 부착
resource "aws_iam_role_policy_attachment" "instance" {
  # 정책을 부착할 역할을 선언
  role = aws_iam_role.instance.name
  # SSM 기반으로 접속할 수 있는 정책 설정
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

# → EC2에 IAM Role을 직접 붙일 수 없어서 Profile이 중간 다리 역할
# → Role(권한)을 Profile(껍데기)에 담아서 EC2에 연결
resource "aws_iam_instance_profile" "instance" {
  name = "${local.project}-iamprofile-instance"

  role = aws_iam_role.instance.name

  tags = {
    Name = "${local.project}-iamprofile-instance"
  }

}

# 보안 그룹 선언 "인스턴스"
resource "aws_security_group" "instance" {
  name = "${local.project}-sg-instance"

  # 아웃바운드 규칙 모든 포트/프로토콜 [0.0.0.0] (외부통신가능)
  # 인바운드 규칙 없음 → SSH/HTTP 등 외부 접근 차단
  egress {
    from_port   = 0             # 모든 포트
    to_port     = 0             # 모든 포트
    protocol    = "-1"          # 모든 프로토콜
    cidr_blocks = ["0.0.0.0/0"] # 모든 IP
  }

  tags = {
    Name = "${local.project}-sg-instance"
  }
}

# ec2 리소스
resource "aws_instance" "instance" {
  # ec2 이미지
  ami = "local.ami"
  # ec2 스펙
  instance_type          = "local.instance_type"
  vpc_security_group_ids = [aws_security_group.instance.id]
  iam_instance_profile   = aws_iam_instance_profile.instance.name

  # depends_on → 명시적 의존성 선언
  # Profile이 Role 정책 부착 완료된 후에 EC2 생성하도록 순서 보장
  # (없으면 권한 없는 상태로 EC2가 먼저 생성될 수 있음)
  depends_on = [aws_iam_role_policy_attachment.instance]

  # 인스턴스 이름 태그
  tags = {
    Name = "${local.project}-instance-micro"
  }
}