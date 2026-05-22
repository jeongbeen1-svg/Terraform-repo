locals {
  project = "tf-core-lab01"

  instance = {
    name = "web"

    ami                         = data.aws_ami.amazon_linux.id
    instance_type               = var.instance_type
    associate_public_ip_address = true

    allow_access = {
      port        = 80
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  iamrole = {
    name = "instance-web"

    assume_role_policy = data.aws_iam_policy_document.ec2_assume_role_policy.json
    policy_arn         = data.aws_iam_policy.aws_ssm_core_policy.arn
  }
}