locals {
  namespace = var.namespace

  vpc_id = var.vpc_id

  instance = {
    name = "web"

    instance_type               = "t3.small"
    ami                         = data.aws_ami.amazon_linux.id
    subnet_id                   = var.instance_subnet_id
    associate_public_ip_address = false
    iam_instance_profile        = var.instance_iam_instance_profile


    user_data = base64encode(templatefile("templates/user_data.sh.tpl", {
      profile     = "dev"
      server_port = 80
    }))
    
    allow_access = {
      port        = 80
      cidr_blocks = var.instance_allow_access_cidr_blocks
    }

  }

  lb = {
    target_group_arn = var.lb_target_group_arn
  }
}