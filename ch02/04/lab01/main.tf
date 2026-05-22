# iam 역할 선언 이름: 인스턴스
resource "aws_iam_role" "instance" {
  # 이름 생성 로컬을 참조조합으로 생성 
  name = "${local.project}-iamrole-${local.iamrole.name}"
  # 임시권한 정책 loacl에 정의
  # assume_role_policy를 local로 뺀 이유
  # → jsonencode() 블록이 길어서 main.tf 가독성을 위해 locals.tf로 분리
  assume_role_policy = local.iamrole.assume_role_policy

  # 이름 태그 생성 로컬 참조조합으로 정의
  tags = {
    Name = "${local.project}-iamrole-${local.iamrole.name}"
  }
}

# iam 역할에 부착할 정책 선언
resource "aws_iam_role_policy_attachment" "instance" {
  # 위 선언한 역할로 지정
  role = aws_iam_role.instance.name
  # 부착할 정책을 local의 iamrole의 policy_arn에 정의
  policy_arn = local.iamrole.policy_arn
}

# iam 역할에 정책을 부착하기 위한 프로파일 생성 (이게 없으면 정책 부착을 못함)
# Role → Profile → EC2 순서로 연결됨
resource "aws_iam_instance_profile" "instance" {
  name = "${local.project}-iamprofile-${local.iamrole.name}"
  # 어떤 역할의 프로파일인지 선언
  role = aws_iam_role.instance.name

  tags = {
    Name = "${local.project}-${local.iamrole.name}"
  }

}

# 보안그룹 리소스 선언
resource "aws_security_group" "instance" {
  name = "${local.project}-sg-instance"

  #  인바운드 규칙 생성
  # → 포트/cidr 값을 local로 관리해서 변경 시 한 곳만 수정하면 됨
  ingress {
    from_port   = local.instance.allow_access.port # local에 포트번호 정의
    to_port     = local.instance.allow_access.port # local에 포트번호 정의
    protocol    = "tcp"                            # tcp 프로토콜
    cidr_blocks = local.instance.allow_access.cidr_blocks
  }

  # 아웃바운드 규칙 생성
  egress {
    from_port   = 0             # 모든 포트
    to_port     = 0             # 모든 포트 
    protocol    = "-1"          # 모든 프로토콜
    cidr_blocks = ["0.0.0.0/0"] # 모든 IP
  }
  # local 참조 조합으로 이름 태그 생성한다
  tags = {
    Name = "${local.project}-sg-${local.instance.name}"
  }
}

# 이름: ssm_test ec2 인스턴스 생성 
resource "aws_instance" "ssm_test" {

  # ec2 스펙값은 local에 정의
  ami           = local.instance.ami
  instance_type = local.instance.instance_type
  # ec2 생성하면서 공인 IP 할당 (이 값에 대해서 local에 정의)
  associate_public_ip_address = local.instance.associate_public_ip_address


  # vpc 보안그룹 id = 인스턴스 보안그룹 id
  vpc_security_group_ids = [aws_security_group.instance.id]
  iam_instance_profile   = aws_iam_instance_profile.instance.name


  # ec2를 생성하기 위해서는 attachment가 먼저 처리되는 순서 보장하는 명시적 의존
  depends_on = [aws_iam_role_policy_attachment.instance]

  tags = {
    Name = "${local.project}-instance-ssm-test"
  }
}
