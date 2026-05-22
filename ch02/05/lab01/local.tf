# variables + providers
locals {
  # 프로젝트 이름은 tf-core-gallery
  project = "tf-core-gallery"

  # datasources.tf에서 조회한 default VPC id 참조
  # → 하드코딩 없이 실제 AWS에서 동적으로 가져옴
  vpc_id = data.aws_vpc.default.id

  # 인스턴스에 대한 값
  instance = {
    name = "web"

    # lab04와 핵심 차이!
    # ami          → 하드코딩 X, datasources에서 최신 AMI 동적 조회
    # instance_type → 하드코딩 X, var.instance_type으로 외부 주입
    # subnet_id    → 하드코딩 X, datasources에서 동적 조회
    ami           = data.aws_ami.amazon_linux.id
    instance_type = var.instance_type
    # 공인 IP 부여
    associate_public_ip_address = true
    subnet_id                   = data.aws_subnets.default.ids[0]

    # 포트/cidr도 variables에서 주입받아 유연하게
    allow_access = {
      port        = var.service_port
      cidr_blocks = var.cidr_blocks
    }
  }

  # IAM 역할
  iamrole = {

    name = "instance-web"

    # lab04와 핵심 차이!
    # assume_role_policy → jsonencode 하드코딩 X
    #                    → datasources의 aws_iam_policy_document로 동적 생성
    # policy_arn         → ARN 문자열 하드코딩 X
    #                    → datasources의 aws_iam_policy로 동적 조회
    assume_role_policy = data.aws_iam_policy_document.ec2_assume_role_policy.json
    policy_arn         = data.aws_iam_policy.aws_ssm_core_policy.arn
  }
}