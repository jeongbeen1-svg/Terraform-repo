variable "namespace" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "lb_subnets" {
  type = list(string)
}