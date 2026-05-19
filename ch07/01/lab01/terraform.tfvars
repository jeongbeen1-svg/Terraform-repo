env = "dev"

infra_lb_listener_port = 80
infra_lt_service_port  = 8080
infra_lt_instance_type = "t3.small"

infra_asg_deploy_version   = "1.0.0"
infra_asg_max_size         = 2
infra_asg_min_size         = 1
infra_asg_desired_capacity = 1