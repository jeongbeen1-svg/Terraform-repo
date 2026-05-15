locals {
  namespace = var.namespace

  vpc_id = var.vpc_id

  lb = {
    name = "main"

    load_balancer_type         = "application"
    internal                   = false
    enable_deletion_protection = false
    subnets                    = var.lb_subnets

    target_group = {
      port        = 80
      protocol    = "HTTP"
      target_type = "instance"

      health_check = {
        enabled             = true
        protocol            = "HTTP"
        path                = "/"
        port                = 80
        healthy_threshold   = 3
        unhealthy_threshold = 3
        timeout             = 5
        interval            = 30
      }
    }

    listener = {
      port        = 80
      cidr_blocks = ["0.0.0.0/0"]
      protocol    = "HTTP"
    }
  }

  iamrole = {
    name       = "instance-web"
    policy_arn = data.aws_iam_policy.aws_ssm_core_policy.arn
  }
}