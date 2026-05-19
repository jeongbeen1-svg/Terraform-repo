locals {
  org         = "tf-core"
  project     = "lab01"
  environment = var.env

  namespace = "${local.org}-${local.project}-${local.environment}"

  vpc_id = data.aws_vpc.default.id

  instance = {
    name = "web"

    ami                         = data.aws_ami.amazon_linux.id
    instance_type               = var.instance_instance_type
    associate_public_ip_address = true
    subnet_id                   = data.aws_subnets.default.ids[0]

    allow_access = {
      port        = 80
      cidr_blocks = var.instance_allow_access_cidr_blocks
    }
  }

  iamrole = {
    name = "instance"

    assume_role_policy = data.aws_iam_policy_document.ec2_assume_role_policy.json
    policy_arn         = data.aws_iam_policy.aws_ssm_core_policy.arn
  }
}