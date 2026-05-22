variable "env" {
  type        = string
  default     = "dev"
  description = "Deployment Env."
}

variable "listener_port" {
  type    = number
  default = 80
}

variable "ha_enabled" {
  type    = bool
  default = true
}

variable "subnet_cidr" {
  type    = list(string)
  default = ["10.0.1.0/24", "10.0.2.0/24", "10.0.1011.0/24", "10.0.102.0/24"]
}
