variable "namespace" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "instance_subnet_id" {
  type = string
}

variable "instance_allow_access_cidr_blocks" {
  type = list(string)
}

variable "instance_iam_instance_profile" {
  type = string
}

variable "lb_target_group_arn" {
  type = string
}