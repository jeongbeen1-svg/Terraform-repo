output "instance" {
  value = {
    (local.instance.name) = {
      id            = aws_instance.this.id
      instance_type = aws_instance.this.instance_type
    }
  }
}

output "sg" {
  value = {
    id   = aws_security_group.this.id
    name = aws_security_group.this.name
  }
}