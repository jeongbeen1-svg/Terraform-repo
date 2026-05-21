# datasources.tf
# AWS에서 기존 리소스 정보를 조회 (생성 X, 읽기만)
# → locals.tf에서 data.xxx.yyy 로 참조됨

# 계정의 default VPC 조회
# → local.vpc_id, 서브넷 필터링에 사용
data "aws_vpc" "default" {
  default = true  # default VPC만 조회
}

# default VPC에 속한 서브넷 목록 조회
# → local.instance.subnet_id = data.aws_subnets.default.ids[0]
data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    # 위에서 조회한 VPC id로 필터링
    values = [data.aws_vpc.default.id]
  }
}

# IAM AssumeRole 신뢰정책을 HCL로 선언
# → lab04의 jsonencode() 하드코딩을 대체
# → locals에서 .json 으로 참조해서 사용
data "aws_iam_policy_document" "ec2_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]  # 임시 자격증명 요청 허용
    effect  = "Allow"

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]  # EC2만 이 역할 사용 가능
    }
  }
}

# AWS 관리형 정책을 이름으로 조회 → ARN 동적으로 가져옴
# → lab04의 ARN 하드코딩을 대체
# "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore" 직접 안써도 됨
data "aws_iam_policy" "aws_ssm_core_policy" {
  name = "AmazonSSMManagedInstanceCore"
}

# 최신 Amazon Linux 2023 AMI를 동적으로 조회
# → lab04의 ami ID 하드코딩을 대체
# → 항상 최신 AMI 자동 적용 (ami-xxx 직접 안써도 됨)
data "aws_ami" "amazon_linux" {
  most_recent = true  # 여러 결과 중 가장 최신 것 선택

  filter {
    name   = "name"
    values = ["al2023-ami-2023.*-x86_64"]  # Amazon Linux 2023 패턴 매칭
  }

  owners = ["amazon"]  # AWS 공식 AMI만 신뢰
}