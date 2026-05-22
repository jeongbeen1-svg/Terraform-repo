variable "instance_type" {
  type        = string
  default     = "t3.micro"
  description = "EC2 Instance Type"

  validation {
    condition     = contains(["t3.micro", "t3.small", "t3.medium"], var.instance_type)
    error_message = "instance_type은 t3.micro, t3.small, t3.medium 중 하나여야 한다."
  }
}