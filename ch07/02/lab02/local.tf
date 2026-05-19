locals {
  org         = "tf-core"
  project     = "lab02"
  environment = terraform.workspace

  namespace = "${local.org}-${local.project}-${local.environment}"

  vpc_id = data.aws_vpc.default.id

  instance = {
    name = "web"

    ami                         = data.aws_ami.amazon_linux.id
    instance_type = (
  local.environment == "dev" ? "t3.micro" : local.environment == "stg" ? "t3.small" : "t3.medium"
)
    associate_public_ip_address = true
    subnet_id                   = data.aws_subnets.default.ids[0]

    allow_access = {
      port        = 80
      cidr_blocks = (
        local.environment == "dev" ? ["218.10.1.0/32"] : local.environment == ["0.0.0.0/0"]
)
    }
  }

  iamrole = {
    name = "instance"

    assume_role_policy = data.aws_iam_policy_document.ec2_assume_role_policy.json
    policy_arn         = data.aws_iam_policy.aws_ssm_core_policy.arn
  }
}